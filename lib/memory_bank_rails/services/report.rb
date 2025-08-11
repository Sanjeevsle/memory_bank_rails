# frozen_string_literal: true

module MemoryBankRails
  module Services
    class Report
      def initialize(root_path)
        @root_path = root_path
      end

      def generate
        specs_root = File.join(@root_path, ".specs")
        return puts("No .specs directory found") unless Dir.exist?(specs_root)

        total = 0
        done = 0

        Dir.glob(File.join(specs_root, "**", "*.md")).each do |file|
          content = File.read(file)
          total += content.scan(/- \[.\]/).size
          done += content.scan(/- \[x\]/i).size
        end

        percent = total.zero? ? 0 : ((done.to_f / total) * 100).round(1)
        puts "Tasks completion: #{done}/#{total} (#{percent}%)"
      end
    end
  end
end
