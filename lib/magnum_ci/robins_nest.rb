module MagnumCI
  class RobinsNest
    def initialize(project, uri, branch)
      @project = project
      @uri = uri
      @branch = branch
    end
    
    def process
      head
      clone
      branch
    end
    
    def head
      @head = `git ls-remote --heads #{@uri} #{@branch} | cut -f1`.chomp
    end
    
    def clone
      Dir.mkdir "#{RAILS_ROOT}/builds" unless File.directory?("#{RAILS_ROOT}/builds")
      Dir.mkdir "#{RAILS_ROOT}/builds/#{@project}" unless File.directory?("#{RAILS_ROOT}/builds/#{@project}")
      `git clone "#{@uri}" "#{RAILS_ROOT}/builds/#{@project}/#{@head}"`
    end
    
    def branch
      Repo.new "#{RAILS_ROOT}/builds/#{@project}/#{@head}"
    end
  end
end