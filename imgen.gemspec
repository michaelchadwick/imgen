# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'imgen/version'

source_uri = 'https://github.com/michaelchadwick/imgen'
rubygem_uri = 'http://rubygems.org/gems/imgen'

Gem::Specification.new do |spec|
  spec.name           = "imgen"
  spec.summary        = 'Create images from scratch'
  spec.version        = Imgen::VERSION
  spec.platform       = Gem::Platform::RUBY
  spec.authors        = ["Michael Chadwick"]
  spec.email          = ["mike@neb.host"]
  spec.homepage       = rubygem_uri
  spec.license        = 'MIT'
  spec.description    = 'Create an image of a specific height and width using Magick'

  spec.files          = `git ls-files`.split("\n")
  spec.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables    = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths  = ['lib']

  spec.metadata       = {
    "documentation_uri" => source_uri,
    "homepage_uri" => source_uri,
    "source_code_uri" => source_uri
  }

  # required deps
  spec.add_runtime_dependency "rmagick"

  # development deps
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
