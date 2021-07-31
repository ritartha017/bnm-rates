# frozen_string_literal: true

require_relative "lib/bnm_rates/version"

Gem::Specification.new do |spec|
  spec.name          = "bnm_rates"
  spec.version       = BnmRates::VERSION
  spec.authors       = ["ritartha017"]
  spec.email         = ["tsmi017@bk.ru"]

  spec.summary       = "Fetches the actual currency rates from bnm.md ."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/ritartha017"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_dependency "money", "~> 6.16.0"
  spec.add_dependency "nokogiri", "~> 1.11.7"
  spec.add_dependency "rest-client", "~> 2"
end
