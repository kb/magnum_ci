module MagnumCI
  module RobinsNest
    @queue = :clone
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        @build.clone!
        RobinsNest.clone
        RobinsNest.repo_data
        @build.queue_build!
        Resque.enqueue(MagnumCI::MustacheRide, @build.id)
      end

      def clone
        `git clone "#{@build.project.repo_uri}" "#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}"`
      end    

      def repo_data
        repo = Repo.new("#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}")
        @build.name = repo.commits.first.id
        @build.committer = repo.commits.first.committer.name
        @build.message = repo.commits.first.message
        @build.save
      end
    end
  end
end
