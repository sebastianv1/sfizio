
lib = File.expand_path("../lib", __FILE__)
require "sfizio/version"

Gem::Specification.new do |spec|
  spec.name          = "sfizio"
  spec.version       = Sfizio::VERSION
  spec.authors       = ["Sebastian Shanus"]
  spec.email         = ["shanus.sebastian@gmail.com"]

  spec.summary       = %q{Sfizio brew formula version management.}
  spec.description   = %q{A refreshing whimsical formula manager for Homebrew.}
  spec.homepage      = "https://www.google.com"

  spec.files = Dir["lib/**/*.rb"] + %w{ bin/sfizio }

  spec.executables   = %w{ sfizio }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
