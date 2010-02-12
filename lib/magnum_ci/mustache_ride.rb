module MagnumCI
  module MustacheRide
    @queue = :build
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        MustacheRide.build
      end
    
      def build
        script = "env - bash --login -c 'cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && #{@build.project.script}'"
        IO.popen(script, "r") { |io| @stdout = io.read }
        @build.passed = true if $?.to_i == 0
        @build.log = RedCloth.new(@stdout).to_html
        @build.save
      end

      def pre_bundler_path
        ENV['PATH'] && ENV["PATH"].split(":").reject { |path| path.include?("vendor") }.join(":")
      end

      def pre_bundler_rubyopt
        ENV['RUBYOPT'] && ENV["RUBYOPT"].split.reject { |opt| opt.include?("vendor") }.join(" ")
      end
    end
  end
end
