require 'active_record'
require 'ox'

module PermalinksLoaders
  module Sources
    class XerxesActiveRecord < ActiveRecord::Base
      def self.db_config
        YAML::load(File.open(File.expand_path("../../../../config/databases/xerxes.yml", __FILE__))).with_indifferent_access
      end
      self.table_name = 'xerxes_databases'
      self.inheritance_column = 'tbd'
      self.establish_connection self.db_config[:xerxes]

      validates :metalib_id, :title_display, :type, :data, presence: true

      def url
        @url ||= parsed_data.try(:database).try(:link_native_home).try(:nodes).try(:first)
      end

    protected

      def parsed_data
        @parsed_data ||= Ox.parse(self.data)
      end
    end
  end
end
