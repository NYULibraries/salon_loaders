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
        Rake::Task["salon_loaders:libguides:logger"].invoke(loader)
      end
    end

    desc 'Spit out information about what permalinks could and could not be processed'
    task :logger, :loader do |t, args|
      args.with_defaults(:loader => SalonLoaders::Sources::Libguides.new)
      loader = args[:loader]
      logger = Logger.new((ENV['LOGGER'] || STDOUT))
      loader.error_records.each do |r|
        logger.info "Could not load resource: LibGuides ID: #{r.id}; LibGuides URL: #{r.url}; LibGuides internal note: #{r.internal_note}"
      end
      logger.info "#{loader.permalinks.count} permalinks created"
      logger.info "#{loader.error_records.count} resources unreadable"
    end
  end

end
