# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "shirtsio/version"
require "rake"

Gem::Specification.new do |spec|
  spec.name          = "shirtsio-ruby"
  spec.version       = Shirtsio::VERSION
  spec.authors       = ["Dean Hailin Song"]
  spec.email         = ["dean.song@movit-tech.com"]
  spec.description   = "The Shirts.io client library"
  spec.summary       = "Ruby version for the Shirts.io client library"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.files         += FileList["lib/shirtsio/errors/*.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency('rest-client', '~> 1.4')
  spec.add_dependency('multi_json', '>= 1.0.4', '< 2')

end

