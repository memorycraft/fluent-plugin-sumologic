# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-sumologic-carsonoid"
  spec.version       = "0.0.3"
  spec.authors       = ["memorycraft", "carsonoid"]
  spec.email         = ["memorycraft@gmail.com", "ca@carson-anderson.com"]
  spec.description   = %q{fluent plugin for sumologic}
  spec.summary       = %q{sumologic is log management system. this plugin is fluent output plugin send to sumologic}
  spec.homepage      = "https://github.com/carsonoid/fluent-plugin-sumologic"
  spec.license       = "MIT"

  spec.rubyforge_project = "fluent-plugin-sumologic-carsonoid"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "fluentd"
end
