module MagnumCI
  module MustacheRide
    @queue = :build
    class << self
      def perform(build_id, project, repo_uri, branch, script)
        @build = Build.find(build_id)
        @project = project
        @repo_uri = repo_uri
        @branch = branch
        @script = script
        MustacheRide.clone
        MustacheRide.build
      end
    
      # TODO: Is this possible to use Grit instead of shelling out here?
      def clone
        # Grab the latest commit bit
        @head = `git ls-remote --heads #{@repo_uri} #{@branch} | cut -f1`.chomp
      
        # Create a directory and clone the project
        Dir.mkdir "#{RAILS_ROOT}/builds" unless File.directory?("#{RAILS_ROOT}/builds")
        Dir.mkdir "#{RAILS_ROOT}/builds/#{@project}" unless File.directory?("#{RAILS_ROOT}/builds/#{@project}")
        `git clone "#{@repo_uri}" "#{RAILS_ROOT}/builds/#{@project}/#{@head}"`
      end
    
      def build
        stdout = `#{@script}`
        @build.passed = true if $?.to_i == 0
        @build.name = @head
        @build.log = RedCloth.new(stdout).to_html
        @build.save
      end
    end
  end
end