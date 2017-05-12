require 'active_record'

module SalonLoaders
  module Sources
    module ActiveRecordSources
      class Base < ActiveRecord::Base
        def self.db_config
          YAML::load(File.open(File.expand_path("../../../../../config/databases.yml", __FILE__))).with_indifferent_access
        end

        self.abstract_class = true
      end
    end
  end
end
