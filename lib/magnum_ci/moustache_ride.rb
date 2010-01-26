require 'systemu'

module MagnumCI
  module MoustacheRide
    @queue = :build
    
    def self.perform(build_id, project, repo_uri, branch, script)
      @build = Build.find(build_id)
      MoustacheRide.clone(project, repo_uri, branch)
      MoustacheRide.build(script)
    end
    
    # TODO: Is this possible to use Grit instead of shelling out here?
    def self.clone(project, repo_uri, branch)
      # Grab the latest commit bit
      head = `git ls-remote --heads #{repo_uri} #{branch} | cut -f1`.chomp
      
      # Create a directory and clone the project
      Dir.mkdir "#{RAILS_ROOT}/builds" unless File.directory?("#{RAILS_ROOT}/builds")
      Dir.mkdir "#{RAILS_ROOT}/builds/#{project}" unless File.directory?("#{RAILS_ROOT}/builds/#{project}")
      `git clone "#{repo_uri}" "#{RAILS_ROOT}/builds/#{project}/#{head}"`
    end
    
    def self.build(script)
      status, stdout, stderr = systemu `#{script}`
      @build.log = stdout
      @build.save
    end
  end
end