# Dir["#{File.dirname(__FILE__)}/lib/permalink_loaders/**/*.rb"].each { |f| load(f) }
require 'lib_guides/api'
require 'permalinks_loaders/permalink'
require 'permalinks_loaders/sources/base'
require 'permalinks_loaders/sources/libguides'
require 'permalinks_loaders/sources/xerxes'

module PermalinksLoaders
end
