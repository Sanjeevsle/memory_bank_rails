# frozen_string_literal: true

require_relative "memory_bank_rails/version"

begin
  require_relative "memory_bank_rails/railtie"
rescue LoadError
  # Railtie is only available in Rails environments
end

require_relative "memory_bank_rails/config"
require_relative "memory_bank_rails/cli"

module MemoryBankRails
  class Error < StandardError; end
  # Your code goes here...
end
