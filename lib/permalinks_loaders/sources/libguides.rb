module PermalinksLoaders
  module Sources
    class Libguides < Base
      attr_accessor :list

      def initialize
        @list = LibGuides::API::Az::List.new
        @permalinks = get_permalinks
      end

      private
      def get_permalinks
        list.load
        list.map do |asset|
          Permalink.new(asset.id, asset.url)
        end
      end
    end
  end
end
