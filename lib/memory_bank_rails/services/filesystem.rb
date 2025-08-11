# frozen_string_literal: true

require "fileutils"

module MemoryBankRails
  module Services
    class Filesystem
      def initialize(root_path)
        @root_path = root_path
      end

      def ensure_dir(relative_path)
        full_path = File.join(@root_path, relative_path)
        FileUtils.mkdir_p(full_path)
        full_path
      end

      def write_file(relative_path, content)
        full_path = File.join(@root_path, relative_path)
        FileUtils.mkdir_p(File.dirname(full_path))
        File.write(full_path, content)
        full_path
      end

      def copy_file(src_path, dest_relative_path)
        full_path = File.join(@root_path, dest_relative_path)
        FileUtils.mkdir_p(File.dirname(full_path))
        FileUtils.cp(src_path, full_path)
        full_path
      end

      def file_exists?(relative_path)
        File.exist?(File.join(@root_path, relative_path))
      end
    end
  end
end
