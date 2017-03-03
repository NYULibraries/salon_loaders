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
        end.join("\n")
      end
      #
      # def self.connection_configured?
      #   config = ActiveRecord::Base.configurations["old_arch"]
      #   (config.try(:[], "adapter").present?)
      # end
      #
      # self.establish_connection :old_arch if self.connection_configured?
      # # ActiveRecord likes it when we tell it this is an abstract class only.
      # self.abstract_class = true
      #
      # # Just to be safe
      # def read_only?
      #   true
      # end
    end
  end
end
