require 'lib_guides/api'

module SalonLoaders
  module Sources
    class Libguides < Base

      def initialize
        @source_data = source_data
        super()
      end

      def get_permalinks
        source_data.inject([]) do |result, asset|
          if asset.resource_url
            result << Permalink.new(key: asset.salon_id, url: asset.resource_url, use_proxy: asset.enable_proxy?) if asset.salon_id
            result << Permalink.new(key: asset.metalib_id, url: asset.resource_url, use_proxy: asset.enable_proxy?) if asset.metalib_id
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
