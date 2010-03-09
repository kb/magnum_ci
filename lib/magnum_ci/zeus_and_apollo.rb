module MagnumCI
  module ZeusAndApollo
    @queue = :delete
    class << self
      def perform(build_id)
        @build = Build.find(build_id)
        ZeusAndApollo.delete_build
      end

      def delete_build
        `rm -rf "#{RAILS_ROOT}/builds/#{@build.project.name}/#{@build.id}"`
        @build.destroy
      end
    end
  end
end
