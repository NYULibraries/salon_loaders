require 'lib_guides/api'

module PermalinksLoaders
  module Sources
    class Libguides < Base

      def initialize
        @key_field = :id
        @url_field = :url
        @source_data = source_data
        super()
      end

    private

      def source_data
        @source_data ||= LibGuides::API::Az::List.new.load
      end

    end
  end
end
