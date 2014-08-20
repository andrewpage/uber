# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uber/version'

Gem::Specification.new do |spec|
  spec.name          = "uber"
  spec.version       = Uber::VERSION
  spec.authors       = ["Andrew Page"]
  spec.email         = ["andrew@andrewpage.me"]
  spec.summary       = "API wrapper for the Uber API"
  spec.description   = "API wrapper for the Uber API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
