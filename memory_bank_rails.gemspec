# frozen_string_literal: true

require_relative "lib/memory_bank_rails/version"

Gem::Specification.new do |spec|
  spec.name = "memory_bank_rails"
  spec.version = MemoryBankRails::VERSION
  spec.authors = ["puppe1990"]
  spec.email = ["matheus.puppe90@hotmail.com"]

  spec.summary = "Rails engine that bootstraps AI-ready docs and project memory for Rails teams."
  spec.description = <<~DESC
    Memory Bank for Agents (Rails) provides generators, rake tasks, and configuration
    to scaffold an opinionated documentation and memory system for Rails apps,
    including SPEC-driven workflows, guides, and optional editor rules.
  DESC
  spec.homepage = "https://github.com/your-org/memory_bank_rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  # Set your private gem server to allow pushing there, or remove if publishing to RubyGems
  # spec.metadata["allowed_push_host"] = "https://example.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/your-org/memory_bank_rails"
  spec.metadata["changelog_uri"] = "https://github.com/your-org/memory_bank_rails/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "railties", ">= 7.0"
  spec.add_dependency "thor", ">= 1.2"

  # Development dependencies are specified in the Gemfile

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
