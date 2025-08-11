# frozen_string_literal: true

require "rails/generators"

module MemoryBank
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      class_option :guide, type: :string, default: "rails_web", desc: "Which guide to install"
      class_option :with_rules, type: :boolean, default: false, desc: "Copy .cursorrules if available"

      def create_config
        template "config/memory_bank.yml.erb", "config/memory_bank.yml"
      end

      def ensure_directories
        empty_directory ".memory_bank"
        empty_directory ".specs"
      end

      def copy_guide
        guide = options["guide"]
        guide_dir = File.join(self.class.source_root, "guides", guide)
        unless Dir.exist?(guide_dir)
          say "Unknown guide: #{guide}", :red
          return
        end

        copy_file File.join("guides", guide, "developmentGuide.md"), ".memory_bank/developmentGuide.md"
        if options["with_rules"] && File.exist?(File.join(guide_dir, ".cursorrules"))
          copy_file File.join("guides", guide, ".cursorrules"), ".cursorrules"
        end
      end
    end
  end
end


