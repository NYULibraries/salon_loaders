module PermalinksLoaders
  module Sources
    class Base
      include Enumerable

      extend Forwardable
      def_delegators :permalinks, :each

      attr_accessor :permalinks, :source_data, :key_field, :url_field

      def initialize
        @permalinks = get_permalinks
      end

      def permalinks
        (@permalinks || [])
      end

      def write_txt(filepath)
        File.open(filepath, 'w'){ |f| f.write to_txt }
      end

      def to_txt
        permalinks.map do |permalink|
          "set #{permalink.key} #{permalink.url}"
        end.join("\r\n") + "\r\n"
      end

    protected

      def get_permalinks
        source_data.map do |link|
          Permalink.new(key: link.send(self.key_field), url: link.send(self.url_field))
        end
      end

    end
  end
end
