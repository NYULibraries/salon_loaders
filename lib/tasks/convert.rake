require_relative '../permalinks_loaders'

namespace :permalinks_loaders do

  namespace :libguides do
    desc 'Generate a Redis-ready key/value txt file from LibGuides data'
    task :txt do
      PermalinksLoaders::Sources::Libguides.new.write_txt "libguides.txt"
    end

    desc 'Generate a Redis-ready key/value json file from LibGuides data'
    task :json do
      PermalinksLoaders::Sources::Libguides.new.write_json "libguides.json"
    end
  end

  namespace :xerxes do
    desc 'Generate a Redis-ready key/value txt file from Xerxes data'
    task :txt do
      PermalinksLoaders::Sources::Xerxes.new.write_txt "xerxes.txt"
    end

    desc 'Generate a Redis-ready key/value json file from Xerxes data'
    task :json do
      PermalinksLoaders::Sources::Xerxes.new.write_json "xerxes.json"
    end
  end

  # desc 'Generate a Redis-ready key/value txt file from LibGuides data'
  # task :libguides do
  #   PermalinksLoaders::Sources::Libguides.new.write_txt "libguides.txt"
  # end
  #
  # desc 'Generate a Redis-ready key/value txt file from Xerxes data'
  # task :xerxes do
  #   PermalinksLoaders::Sources::Xerxes.new.write_txt "xerxes.txt"
  # end

end
