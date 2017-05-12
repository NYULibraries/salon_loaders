require_relative 'active_record_sources/xerxes'

module SalonLoaders
  module Sources
    class Xerxes < Base

      def initialize
        @key_field = :metalib_id
        @url_field = :url
        @source_data = source_data
        super()
      end

    private

      def source_data
        @source_data ||= ActiveRecordSources::Xerxes.all.reject {|p| p.url.blank? }
      end

    end
  end
end
