require 'lib_guides/api'

module SalonLoaders
  module Sources
    class Libguides < Base
      attr_reader :logger, :resources_read, :permalinks_created, :resources_unreadable, :unreadable_resources

      def initialize
        @source_data = source_data
        @logger = Logger.new((ENV['SALON_LOGGER'] || STDOUT))
        @resources_read, @permalinks_created, @resources_unreadable = 0, 0, 0
        @unreadable_resources = []
        super()
      end

      def get_permalinks
        source_data.inject([]) do |result, asset|
          if asset.resource_url
            @resources_read += 1
            if asset.salon_id
              @permalinks_created += 1
              result << Permalink.new(key: asset.salon_id, url: asset.resource_url, use_proxy: asset.enable_proxy?)
            end
            if asset.metalib_id
              @permalinks_created += 1
              result << Permalink.new(key: asset.metalib_id, url: asset.resource_url, use_proxy: asset.enable_proxy?)
            end
          else
            @resources_unreadable += 1
            @unreadable_resources << "Could not load resource: LibGuides ID: #{asset.id}; LibGuides URL: #{asset.url}; LibGuides library review: #{asset.library_review}"
          end
          result
        end
      end

    private

      def source_data
        LibGuides::API::Az::List.new.load.map do |api_asset|
          LibguidesWrapper::AzAsset.new api_asset
        end
      end

    end
  end
end
