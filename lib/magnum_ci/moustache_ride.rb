module MagnumCI
  module MoustacheRide
    @queue = :build
    
    def perform(build_id, project, repo_uri, branch, script)
      @build = Build.find(build_id)
      clone(project, repo_uri, branch)
    end
    
    # TODO: Is this possible to use Grit instead of shelling out here?
    def clone(project, repo_uri, branch)
      # Grab the latest commit bit
      head = `git ls-remote --heads #{repo_uri} #{branch} | cut -f1`.chomp
      
      # Create a directory and clone the project
      Dir.mkdir "#{RAILS_ROOT}/builds" unless File.directory?("#{RAILS_ROOT}/builds")
      Dir.mkdir "#{RAILS_ROOT}/builds/#{project}" unless File.directory?("#{RAILS_ROOT}/builds/#{project}")
      `git clone "#{repo_uri}" "#{RAILS_ROOT}/builds/#{project}/#{head}"`
    end
  end
end