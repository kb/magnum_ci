module DeleteBuild
  @queue = :delete
  class << self
    def perform(id)
      build = Build.find(id)
      `rm -rf "#{Rails.root}/builds/#{build.project.name}/#{build.id}"`
      build.destroy
    end
  end
end
