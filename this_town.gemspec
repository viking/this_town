# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'this_town/version'

Gem::Specification.new do |gem|
  gem.name          = "this_town"
  gem.version       = ThisTown::VERSION
  gem.authors       = ["Jeremy Stephens"]
  gem.email         = ["jeremy.f.stephens@vanderbilt.edu"]
  gem.description   = %q{Gem generator for Sinatra applications that use the following libraries: sequel, mustache, test-unit, rack-test, mocha, guard}
  gem.summary       = %q{Gem generator for Sinatra applications}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
