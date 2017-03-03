require_relative 'xerxes_active_record'

module PermalinksLoaders
  module Sources
    class Xerxes < Base

      def initialize()
        @permalinks = get_permalinks
      end

      private

      def xerxes_active_records
        @xerxes_active_records ||= XerxesActiveRecord.all
      end

      def get_permalinks
        xerxes_active_records.map do |record|
          Permalink.new(record.metalib_id, record.url)
        end.reject { |p| p.url.blank? }
      end

    end
  end
end
