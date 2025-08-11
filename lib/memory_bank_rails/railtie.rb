# frozen_string_literal: true

require "rails/railtie"

module MemoryBankRails
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.expand_path("../tasks/memory_bank_rails.rake", __dir__)
    end

    # Autoload generators
    initializer "memory_bank_rails.load_generators" do
      ActiveSupport.on_load(:after_initialize) do
        # no-op; ensures generator files are loaded
      end
    end
  end
end
