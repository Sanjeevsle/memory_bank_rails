# frozen_string_literal: true

require "rails/generators"
require "fileutils"
require_relative "../../../memory_bank_rails/config"

module MemoryBank
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      class_option :guide, type: :string, default: "select", desc: "Which guide to install (or 'select' to choose interactively)"
      class_option :with_rules, type: :boolean, default: false, desc: "Copy editor rules (.cursorrules, RuboCop, Solargraph) if available"

      def create_config
        template "config/memory_bank.yml.erb", "config/memory_bank.yml"
      end

      def ensure_directories
        empty_directory ".memory_bank"
        empty_directory ".specs"
      end

      def copy_guide
        config = MemoryBankRails::Config.load(destination_root)
        guides_path = config.dig("memory_bank", "guides_path")
        guide = options["guide"].to_s

        if guide == "select"
          guide, source_kind, external_full_path = select_guide_interactively(guides_path)
        else
          source_kind, external_full_path = resolve_guide_source(guide, guides_path)
        end

        case source_kind
        when :builtin
          copy_file File.join("guides", guide, "developmentGuide.md"), ".memory_bank/developmentGuide.md"
          if options["with_rules"] && File.exist?(File.join(self.class.source_root, "guides", guide, ".cursorrules"))
            copy_file File.join("guides", guide, ".cursorrules"), ".cursorrules"
          end
        when :external
          copy_external_guide_files(external_full_path)
        else
          say "Unknown guide: #{guide}", :red
          return
        end

        install_editor_rules if options["with_rules"]
      end

      private

      def resolve_guide_source(guide, guides_path)
        builtin_dir = File.join(self.class.source_root, "guides", guide)
        return [:builtin, nil] if Dir.exist?(builtin_dir)

        if guides_path
          expanded = File.expand_path(guides_path)
          external_dir = File.join(expanded, guide)
          return [:external, external_dir] if Dir.exist?(external_dir)
        end

        [:unknown, nil]
      end

      def select_guide_interactively(guides_path)
        builtin = available_builtin_guides
        external = available_external_guides(guides_path)
        options = []
        builtin.each { |g| options << ["📦 #{g} (builtin)", :builtin, g, nil] }
        external.each { |g, path| options << ["🔧 #{g} (external)", :external, g, path] }

        if options.empty?
          say "No guides available. Falling back to builtin 'rails_web'", :yellow
          return ["rails_web", :builtin, nil]
        end

        say "\n🚀 Memory Bank Initializer (Rails)", :green
        say "=================================\n"
        options.each_with_index do |(label, _kind, _slug, _path), idx|
          say format("%2d) %s", idx + 1, label)
        end
        choice = ask("\n? What type of memory bank would you like to install? (1-#{options.size})").to_i
        choice = 1 if choice < 1 || choice > options.size
        label, kind, slug, full_path = options[choice - 1]
        [slug, kind, full_path]
      end

      def available_builtin_guides
        Dir.children(File.join(self.class.source_root, "guides")).select do |entry|
          File.exist?(File.join(self.class.source_root, "guides", entry, "developmentGuide.md"))
        end.sort
      end

      def available_external_guides(guides_path)
        return [] unless guides_path
        expanded = File.expand_path(guides_path)
        return [] unless Dir.exist?(expanded)
        Dir.children(expanded).filter_map do |entry|
          full = File.join(expanded, entry)
          guide_md = File.join(full, "developmentGuide.md")
          File.directory?(full) && File.exist?(guide_md) ? [entry, full] : nil
        end.sort_by(&:first)
      end

      def copy_external_guide_files(external_dir)
        source_md = File.join(external_dir, "developmentGuide.md")
        unless File.exist?(source_md)
          say "External guide is missing developmentGuide.md: #{external_dir}", :red
          return
        end
        FileUtils.cp(source_md, File.join(destination_root, ".memory_bank", "developmentGuide.md"))

        rules = File.join(external_dir, ".cursorrules")
        if options["with_rules"] && File.exist?(rules)
          FileUtils.cp(rules, File.join(destination_root, ".cursorrules"))
        end
      end

      def install_editor_rules
        # Copy base RuboCop and Solargraph configs if they don't exist
        rubocop_template = File.join("editor", ".rubocop.yml")
        solargraph_template = File.join("editor", ".solargraph.yml")

        rubocop_target = File.join(destination_root, ".rubocop.yml")
        solargraph_target = File.join(destination_root, ".solargraph.yml")

        copy_file(rubocop_template, ".rubocop.yml") unless File.exist?(rubocop_target)
        copy_file(solargraph_template, ".solargraph.yml") unless File.exist?(solargraph_target)
      end
    end
  end
end


