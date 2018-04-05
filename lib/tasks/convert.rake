require_relative '../salon_loaders'

namespace :salon_loaders do

  namespace :libguides do
    desc 'Generate a Redis-ready key/value txt file from LibGuides data; provide envvars LIB_GUIDES_CLIENT_ID and LIB_GUIDES_CLIENT_SECRET'
    task :txt do
      SalonLoaders::Sources::Libguides.new.write_txt "libguides.txt"
    end

    desc 'Generate a Redis-ready key/value json file from LibGuides data'
    task :json do
      loader = SalonLoaders::Sources::Libguides.new
      loader.write_json("libguides.json")
      if ENV["DEBUG"]
        loader.unreadable_resources.map {|r| loader.logger.info r }
        loader.logger.info "#{loader.resources_read} resources read"
        loader.logger.info "#{loader.permalinks_created} permalinks created"
        loader.logger.info "#{loader.resources_unreadable} resources unreadable"
      end
    end
  end

end
