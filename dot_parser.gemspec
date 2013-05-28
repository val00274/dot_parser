# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dot_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "dot_parser"
  spec.version       = DotParser::VERSION
  spec.authors       = ["asatou"]
  spec.email         = ["asatou@val.co.jp"]
  spec.description   = %q{DOT Parser}
  spec.summary       = %q{DOT Parser}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "racc"
  spec.add_development_dependency "rspec"
end

