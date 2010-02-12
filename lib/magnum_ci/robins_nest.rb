module MagnumCI
  module RobinsNest
    @queue = :clone
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        RobinsNest.head
        RobinsNest.clone
        Resque.enqueue(MustacheRide, @build.id)
      end
    
      def head
        @build.name = `git ls-remote --heads #{@build.project.repo_uri} #{@build.project.branch} | cut -f1`.chomp
        @build.save
      end

      def clone
        `git clone "#{@build.project.repo_uri}" "#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}"`
      end
    end
  end
end
