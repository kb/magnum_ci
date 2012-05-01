require "socket"

# The irc class, which talks to the server and holds the main event loop
class IRC
  def initialize(server, port, nick, channel)
      @server = server
      @port = port
      @nick = nick
      @channel = channel
      @irc = ::TCPSocket.open(@server, @port)
      send "USER blah blah blah :blah blah"
      send "NICK #{@nick}"
      send "JOIN #{@channel}"
      puts "(Tried to) Connected to IRC server"
  end
  def send(s)
      # Send a message to the irc server and print it to the screen
      puts "--> #{s}"
      @irc.send "#{s}\n", 0 
  end
  def destroy
    send "server disconnect"
    @irc.close
    puts "Disconnected from IRC server"
  end
end

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
        script = "(cd #{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id} && unset GEM_PATH && unset RUBYOPT && unset RAILS_ENV && unset BUNDLE_GEMFILE && #{@build.project.script} 2>&1)"
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
      
      if @build.project.irc
        @irc = IRC.new(@build.project.ircserver, '6667', @build.project.ircnick, @build.project.channel)
        sleep 4
        @irc.send("privmsg #{@build.project.channel} :#{@build.project.name.titleize} commit #{@build.name} pushed by #{@build.committer} #{@build.pass_fail} \[ #{APP_CONFIG[:site][:address]}/#{@build.project.name}/builds/#{@build.id} \]\n")
        @irc.destroy
      end
    end    
  end
end
