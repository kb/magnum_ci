module MagnumCI
  module MustacheRide
    @queue = :build
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        @build.run_build!
        MustacheRide.build
        @build.complete_build!
      end
    
      def build
        script = "env - bash --login -c 'cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && #{@build.project.script}'"
        IO.popen(script, "r") { |io| @stdout = io.read }
        @build.passed = true if $?.to_i == 0
        @build.log = RedCloth.new(@stdout).to_html
        @build.save
      end
    end
  end
end
