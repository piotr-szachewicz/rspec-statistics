# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/statistics/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-statistics"
  spec.version       = RSpec::Statistics::VERSION
  spec.authors       = ["Piotr Szachewicz"]
  spec.email         = ["piotr.szachewicz@gmail.com"]

  spec.summary       = %q{Gathers performance statistics about your RSpecs.}
  spec.description   = %q{RSpec extension for gathering and exporting to CSV performance statistics (run time of each example, number of requests and database queries made.}
  spec.homepage      = "https://github.com/piotr-szachewicz/rspec-statistics"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rspec"
end
