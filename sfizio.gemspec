
lib = File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "sfizio"
  spec.version       = "0.1.0"
  spec.authors       = ["Sebastian Shanus"]
  spec.email         = ["shanus.sebastian@gmail.com"]

  spec.summary       = %q{Homebrew version management tool}
  spec.description   = %q{A refreshing whimsical formula manager for Homebrew.}
  spec.homepage      = "https://github.com/sebastianv1/sfizio"

  spec.files = Dir["lib/**/*.rb"] + %w{ bin/sfizio }

  spec.executables   = %w{ sfizio }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
