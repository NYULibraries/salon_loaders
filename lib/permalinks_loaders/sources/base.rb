module PermalinksLoaders
  module Sources
    class Base
      include Enumerable

      extend Forwardable
      def_delegators :permalinks, :each

      attr_accessor :permalinks

      def initialize()
        # Load resources
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
        end.join("\n") + "\n"
      end
    end
  end
end
