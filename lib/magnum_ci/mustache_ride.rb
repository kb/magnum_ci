module MagnumCI
  module MustacheRide
    @queue = :build
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        @build.run_build!
        MustacheRide.build
        @build.complete_build!
        MustacheRide.notify
      end
    
      def build
        if @build.project.bundler?
          script = "(cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && export BUNDLE_GEMFILE=$PWD/Gemfile && #{@build.project.script} 2>&1)"
        else
          script = "(cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && #{@build.project.script} 2>&1)"
        end
        
        IO.popen(script, "r") { |io| @build.log = io.read }
        @build.passed = true if $?.to_i == 0
        @build.save
      end

      def notify
        if @build.project.campfire
          Broach.settings = @build.project.campfire_settings
          Broach.speak(@build.project.room, "#{@build.project.name.titleize} commit #{@build.name} pushed by #{@build.committer} #{@build.pass_fail} [ #{APP_CONFIG[:site][:address]}/#{@build.project.name}/builds/#{@build.id} ]")
        end
      end
    end
  end
end
