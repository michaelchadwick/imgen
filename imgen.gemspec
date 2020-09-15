# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imgen/version'

Gem::Specification.new do |spec|
  spec.name           = "imgen"
  spec.version        = Imgen::VERSION
  spec.authors        = ["Michael Chadwick"]
  spec.email          = ["michael.chadwick@gmail.com"]
  spec.homepage       = 'http://rubygems.org/gems/imgen'
  spec.summary        = 'Create images from scratch'
  spec.description    = 'Create an image of a specific height and width using Magick'

  spec.files          = `git ls-files`.split("\n")
  spec.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables    = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths  = ['lib']
  spec.license        = 'MIT'

  spec.add_runtime_dependency "rmagick"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
