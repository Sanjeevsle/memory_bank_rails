# frozen_string_literal: true

require_relative "filesystem"

module MemoryBankRails
  module Services
    class SpecGenerator
      def initialize(root_path)
        @fs = Filesystem.new(root_path)
      end

      def generate(feature_slug)
        raise ArgumentError, "feature slug is required" if feature_slug.to_s.strip.empty?

        base = File.join(".specs", feature_slug)
        @fs.ensure_dir(base)
        @fs.write_file(File.join(base, "requirements.md"), requirements_template(feature_slug))
        @fs.write_file(File.join(base, "design.md"), design_template(feature_slug))
        @fs.write_file(File.join(base, "tasks.md"), tasks_template(feature_slug))
      end

      private

      def requirements_template(feature_slug)
        <<~MD
          # Requirements: #{feature_slug}

          ## User Stories
          - As a <role>, I want <capability> so that <benefit>.

          ## Acceptance Criteria
          - [ ] Criterion 1
          - [ ] Criterion 2
        MD
      end

      def design_template(feature_slug)
        <<~MD
          # Design: #{feature_slug}

          ## Overview
          Describe architecture, patterns, data flow.

          ## Components
          - Component A
          - Component B
        MD
      end

      def tasks_template(feature_slug)
        <<~MD
          # Tasks: #{feature_slug}

          - [ ] Task 1
          - [ ] Task 2
        MD
      end
    end
  end
end


