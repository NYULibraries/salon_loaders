# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salon_loaders/version'

Gem::Specification.new do |gem|
  gem.name          = "salon_loaders"
  gem.version       = SalonLoaders::VERSION
  gem.authors       = ["Eric Griffis", "Barnaby Alter"]
  gem.email         = ["eg131@nyu.edu"]
  gem.description   = %q{Load content from various sources into Salon application to create permalinks in key-value store}
  gem.summary       = %q{Load content from various sources into Salon application to create permalinks in key-value store}
  gem.homepage      = "https://github.com/NYULibraries/salon_loaders"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.licenses      = ['MIT']

  gem.required_ruby_version = '>= 2.4.0'
  gem.add_dependency 'rake', '>= 12'
  gem.add_dependency 'mysql2'
  gem.add_dependency 'activerecord'
  gem.add_dependency 'ox'
end
