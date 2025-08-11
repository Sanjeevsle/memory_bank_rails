# frozen_string_literal: true

require "yaml"
require "erb"

module MemoryBankRails
  class Config
    DEFAULTS = {
      "memory_bank" => {
        "guides_path" => nil,
        "default_guide" => "rails_web"
      }
    }.freeze

    def self.load(root_path)
      config_path = File.join(root_path, "config", "memory_bank.yml")
      return DEFAULTS unless File.exist?(config_path)

      yaml = ERB.new(File.read(config_path)).result
      user_config = YAML.safe_load(yaml) || {}
      deep_merge(DEFAULTS, user_config)
    rescue StandardError
      DEFAULTS
    end

    def self.deep_merge(base, override)
      base.merge(override) do |_key, old_val, new_val|
        if old_val.is_a?(Hash) && new_val.is_a?(Hash)
          deep_merge(old_val, new_val)
        else
          new_val
        end
      end
    end
  end
end
