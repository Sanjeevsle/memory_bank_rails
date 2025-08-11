# frozen_string_literal: true

RSpec.describe MemoryBankRails do
  it "has a version number" do
    expect(MemoryBankRails::VERSION).not_to be nil
  end

  it "loads Railtie in Rails contexts" do
    expect { require "memory_bank_rails/railtie" }.not_to raise_error
  end
end
