# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_subdir/version'

Gem::Specification.new do |spec|
  spec.name          = "rake_subdir"
  spec.version       = RakeSubdir::VERSION
  spec.authors       = ["Oleg Utkin"]
  spec.email         = ["utkin.oleg@me.com"]
  spec.description   = %q{Rucursive gem invocation}
  spec.summary       = %q{Rucursive gem invocation, so that chained execution of Rakefiles is possible. Much like with "make -C".}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "eventmachine"
  spec.add_runtime_dependency "em_pessimistic"
end
