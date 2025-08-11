# frozen_string_literal: true

require_relative "filesystem"

module MemoryBankRails
  module Services
    class Initializer
      DOC_FILES = {
        ".memory_bank/projectBrief.md" => "# Project Brief\n\nDescribe the scope, goals, and success criteria.\n",
        ".memory_bank/productContext.md" => "# Product Context\n\nVision, personas, UX goals.\n",
        ".memory_bank/activeContext.md" => "# Active Context\n\nCurrent focus, decisions, next steps.\n",
        ".memory_bank/systemPatterns.md" => "# System Patterns\n\nShared architecture and patterns.\n",
        ".memory_bank/techContext.md" => "# Tech Context\n\nStack, dependencies, CI/CD, linting.\n",
        ".memory_bank/progress.md" => "# Progress\n\nStatus, milestones, known issues.\n"
      }.freeze

      def initialize(root_path)
        @fs = Filesystem.new(root_path)
      end

      def initialize_docs
        @fs.ensure_dir(".memory_bank")
        DOC_FILES.each { |path, content| @fs.write_file(path, content) }
      end
    end
  end
end
