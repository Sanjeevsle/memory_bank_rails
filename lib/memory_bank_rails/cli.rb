# frozen_string_literal: true

module MemoryBankRails
  class CLI
    def self.exec(command)
      case command.to_s
      when "init"
        invoke_task("memory_bank:init")
      when "initialize"
        invoke_task("memory_bank:initialize")
      when "check"
        invoke_task("memory_bank:check")
      when "report"
        invoke_task("memory_bank:report")
      else
        warn "Unknown command: #{command}"
        exit 1
      end
    end

    def self.run(command)
      exec(command)
    end

    def self.invoke_task(task_name)
      require "rake"
      Rake::Task.clear
      MemoryBankRails.load_rake_tasks
      Rake::Task[task_name].invoke
    end
  end

  def self.load_rake_tasks
    load File.expand_path("../tasks/memory_bank_rails.rake", __dir__)
  end
end

# Backwards compatible alias used in README one-off example
module MemoryBank
  class CLI
    def self.run(command)
      MemoryBankRails::CLI.run(command)
    end
  end
end


