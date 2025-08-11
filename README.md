# Memory Bank for Agents (Rails)

A Rails engine that bootstraps AI-ready development docs and project memory for Ruby on Rails teams. It ships generators, rake tasks, and optional IDE rules to keep context consistent across teammates and AI agents.

## Installation

Add to your `Gemfile`:

```ruby
gem "memory_bank_rails"
```

Then:

```bash
bundle install
rails g memory_bank:install
```

One-off (no Gemfile):

```bash
bundle exec rails runner 'MemoryBankRails::CLI.run("init")'
```

## Rake tasks

```bash
rake memory_bank:init GUIDE=rails_web WITH_RULES=true
rake memory_bank:initialize
rake memory_bank:spec:new FEATURE=my-feature
rake memory_bank:check
rake memory_bank:report
```
