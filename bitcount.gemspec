require_relative 'lib/bitcount/version'

Gem::Specification.new do |spec|
  spec.name          = "bitcount"
  spec.version       = Bitcount::VERSION
  spec.authors       = ["Pavel Rosický"]
  spec.email         = ["pdahorek@seznam.cz"]

  spec.summary       = %q{Bitcount helper methods.}
  spec.homepage      = "https://github.com/ahorek/bitcount"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.platform      = Gem::Platform::RUBY
  spec.extensions    = ["ext/extconf.rb"]

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.require_paths = ["lib", "lib/bitcount"]

  spec.add_runtime_dependency 'ffi'
end
