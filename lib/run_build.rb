class RunBuild
  @queue = :build
  class << self
    def perform(id)
      @build = Build.find(id)
      self.build
    end

    def build
      @build.run_build!
      if @build.project.bundler?
        script = "(cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && export BUNDLE_GEMFILE=$PWD/Gemfile && #{@build.project.script} 2>&1)"
      else
        script = "(cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && #{@build.project.script} 2>&1)"
      end

      IO.popen(script, "r") { |io| @build.log = io.read }
      @build.passed = true if $?.to_i == 0
      @build.save
      @build.complete_build!
      self.notify
    end

    def notify
      if @build.project.campfire
        Broach.settings = @build.project.campfire_settings
        Broach.speak(@build.project.room, "#{@build.project.name.titleize} commit #{@build.name} pushed by #{@build.committer} #{@build.pass_fail} [ #{APP_CONFIG[:site][:address]}/#{@build.project.name}/builds/#{@build.id} ]")
      end
    end
  end
end
