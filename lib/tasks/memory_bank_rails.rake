# frozen_string_literal: true

require "fileutils"
require "yaml"
require File.expand_path("../memory_bank_rails/services/initializer", __dir__)
require File.expand_path("../memory_bank_rails/services/spec_generator", __dir__)
require File.expand_path("../memory_bank_rails/services/checker", __dir__)
require File.expand_path("../memory_bank_rails/services/report", __dir__)

namespace :memory_bank do
  desc "Install Memory Bank (non-interactive). Options: GUIDE=rails_web WITH_RULES=true"
  task :init do
    guide = ENV["GUIDE"] || "rails_web"
    with_rules = ENV["WITH_RULES"] == "true"

    if defined?(Rails::Generators)
      Rails::Generators.invoke("memory_bank:install", ["--guide=#{guide}", (with_rules ? "--with-rules" : nil)].compact)
    else
      puts "Rails generators not available. Run within a Rails app."
      exit 1
    end
  end

  desc "Initialize Memory Bank docs suite (.memory_bank/*)"
  task :initialize do
    root = defined?(Rails) ? Rails.root.to_s : Dir.pwd
    MemoryBankRails::Services::Initializer.new(root).initialize_docs
    puts "Initialized .memory_bank docs"
  end

  desc "Generate a new SPEC. Usage: rake memory_bank:spec:new FEATURE=feature-slug"
  task "spec:new" do
    feature = ENV["FEATURE"]
    if feature.to_s.strip.empty?
      puts "FEATURE is required"
      exit 1
    end
    root = defined?(Rails) ? Rails.root.to_s : Dir.pwd
    MemoryBankRails::Services::SpecGenerator.new(root).generate(feature)
    puts "Created .specs/#{feature}"
  end

  desc "Check Memory Bank files exist"
  task :check do
    root = defined?(Rails) ? Rails.root.to_s : Dir.pwd
    ok = MemoryBankRails::Services::Checker.new(root).verify!
    exit(1) unless ok
  end

  desc "Generate simple tasks completion report"
  task :report do
    root = defined?(Rails) ? Rails.root.to_s : Dir.pwd
    MemoryBankRails::Services::Report.new(root).generate
  end

  desc "Configure custom guides via config/memory_bank.yml. Options: GUIDES_PATH=~/guides DEFAULT_GUIDE=company-rails"
  task :configure do
    root = defined?(Rails) ? Rails.root.to_s : Dir.pwd
    config_path = File.join(root, "config", "memory_bank.yml")
    FileUtils.mkdir_p(File.dirname(config_path))

    current = File.exist?(config_path) ? YAML.safe_load(File.read(config_path)) : {}
    current ||= {}
    current["memory_bank"] ||= {}
    current["memory_bank"]["guides_path"] = ENV["GUIDES_PATH"] if ENV["GUIDES_PATH"]
    current["memory_bank"]["default_guide"] = ENV["DEFAULT_GUIDE"] if ENV["DEFAULT_GUIDE"]

    File.write(config_path, current.to_yaml)
    puts "Updated #{config_path}"
  end
end


