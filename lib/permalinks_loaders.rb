# Dir["#{File.dirname(__FILE__)}/lib/permalink_loaders/**/*.rb"].each { |f| load(f) }
require 'lib_guides/api'
require_relative 'permalinks_loaders/permalink'
require_relative 'permalinks_loaders/sources/base'
require_relative 'permalinks_loaders/sources/libguides'
require_relative 'permalinks_loaders/sources/xerxes'

module PermalinksLoaders
end
