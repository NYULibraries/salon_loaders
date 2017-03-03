require 'ox'
require_relative 'base'

module PermalinksLoaders
  module Sources
    module ActiveRecordSources
      class Xerxes < Base
        self.establish_connection self.db_config[:xerxes]
        self.table_name = 'xerxes_databases'
        self.inheritance_column = 'tbd'

        validates :metalib_id, :title_display, :type, :data, presence: true

        def url
          @url ||= parsed_data.try(:database).try(:link_native_home).try(:nodes).try(:first)
        end

        def db_config_name
          :xerxes
        end

      protected

        def parsed_data
          @parsed_data ||= Ox.parse(self.data)
        end
      end
    end
  end
end
