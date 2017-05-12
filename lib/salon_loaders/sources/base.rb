module SalonLoaders
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
        # File.open(filepath, 'w'){ |f| f.write to_txt }
        write_file(filepath){ to_txt }
      end

      def write_json(filepath)
        write_file(filepath){ to_json }
      end

      def to_txt
        permalinks.map do |permalink|
          "set #{permalink.key} #{permalink.url}"
        end.join("\r\n") + "\r\n"
      end

      def to_json
        permalinks.map do |permalink|
          [permalink.key, permalink.url]
        end.to_h
      end

    protected

      def get_permalinks
        source_data.map do |link|
          Permalink.new(key: link.send(self.key_field), url: link.send(self.url_field))
        end
      end

    private

      def write_file(filepath, &block)
        File.open(filepath, 'w'){ |f| f.write yield }
      end

    end
  end
end
