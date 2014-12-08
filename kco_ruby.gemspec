# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kco_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "kco_ruby"
  spec.version       = KcoRuby::VERSION
  spec.authors       = ["Peter Hagström"]
  spec.email         = ["peter@significantbit.se"]
  spec.summary       = "A port of Klarna Checkout API to Ruby"
  spec.description   = "Klarna Checkout library"
  spec.homepage      = "https://github.com/significantbit/kco_ruby"
  spec.license       = "Apache 2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sys-uname", "~> 0.9", '> 0.9.1'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "webmock", "~> 1.8"
  spec.add_development_dependency "simplecov",  "~> 0.9"
end
