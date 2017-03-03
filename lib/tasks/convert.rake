require_relative '../permalinks_loaders'

namespace :permalinks_loaders do

  desc 'Generate a Redis-ready key/value txt file from LibGuides data'
  task :libguides do
    PermalinksLoaders::Sources::Libguides.new.write_txt "libguides.txt"
  end

  desc 'Generate a Redis-ready key/value txt file from Xerxes data'
  task :xerxes do
    PermalinksLoaders::Sources::Xerxes.new.write_txt "xerxes.txt"
  end

end
