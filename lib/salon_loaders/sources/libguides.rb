require 'lib_guides/api'

module SalonLoaders
  module Sources
    class Libguides < Base
      attr_accessor :error_records

      def initialize
        @source_data = source_data
        @error_records = []
        super()
      end

      def get_permalinks
        source_data.inject([]) do |result, asset|
          if asset.resource_url
            if asset.salon_id
              result << Permalink.new(key: asset.salon_id, url: asset.resource_url, use_proxy: asset.enable_proxy?)
            end
            if asset.metalib_id
              result << Permalink.new(key: asset.metalib_id, url: asset.resource_url, use_proxy: asset.enable_proxy?)
            end
          else
            error_records << asset
          end
          result.uniq(&:key)
        end
      end

      def source_data
        LibGuides::API::Az::List.new.load.map do |api_asset|
          LibguidesWrapper::AzAsset.new api_asset
        end
      end

    end
  end
end
