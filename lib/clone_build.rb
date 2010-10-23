class CloneBuild
  @queue = :clone
  class << self
    def perform(id)
      @build = Build.find(id)
      self.clone
      Resque.enqueue(RunBuild, @build.id)
    end

    def clone
      @build.clone!
      `git clone "#{@build.project.repo_uri}" "#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}"`
      repo = Repo.new("#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}")
      @build.name = repo.commits.first.id
      @build.committer = repo.commits.first.committer.name
      @build.message = repo.commits.first.message
      @build.save
      @build.queue_build!
    end
  end
end

