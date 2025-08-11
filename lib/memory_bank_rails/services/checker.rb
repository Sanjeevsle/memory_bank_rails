# frozen_string_literal: true

module MemoryBankRails
  module Services
    class Checker
      REQUIRED_FILES = %w[
        .memory_bank/projectBrief.md
        .memory_bank/productContext.md
        .memory_bank/activeContext.md
        .memory_bank/systemPatterns.md
        .memory_bank/techContext.md
        .memory_bank/progress.md
      ].freeze

      def initialize(root_path)
        @root_path = root_path
      end

      def verify!
        missing = REQUIRED_FILES.reject { |p| File.exist?(File.join(@root_path, p)) }
        if missing.empty?
          puts "Memory Bank: OK"
          true
        else
          puts "Missing files:" 
          missing.each { |m| puts " - #{m}" }
          false
        end
      end
    end
  end
end


