# Memory Bank for Agents (Rails)

A Rails engine that bootstraps **AI-ready development docs** and **project memory** for Ruby on Rails teams. It ships generators, rake tasks, and optional IDE rules to keep context consistent across teammates and AI agents.

## 🚀 Overview

**Memory Bank for Agents (Rails)** installs a structured documentation system, SPEC-driven feature workflow, and optional editor rules. Perfect for:

* Rails (full-stack or API-only)
* Plain Ruby service objects / gems inside your monorepo
* Background jobs (Sidekiq/ActiveJob) and service-oriented codebases

## ✨ Features

* 🎯 **AI-Ready Setup**: Rails generators scaffold an opinionated docs workspace for agent collaboration
* 📚 **Memory Management**: Organized Markdown docs for durable project knowledge
* ⚙️ **Rails Native**: Installers, rake tasks, config under `config/memory_bank.yml`
* 🧪 **SPEC-Driven Development**: Generators for requirements, design, and task breakdowns
* 🧰 **Editor/Tooling Hooks**: Optional `.cursorrules`, RuboCop base config, and Solargraph hints
* 🔧 **Custom Guides**: Point to your company playbooks and have them copied in on install
* 🧯 **Zero Config Defaults**: Sensible paths; override via YAML when you need to

---

## 📦 Installation

Add to your `Gemfile`:

```ruby
gem "memory_bank_rails"
```

Then:

```bash
bundle install
rails g memory_bank:install
```

The installer will create `config/memory_bank.yml` and (optionally) copy a default guide and `.cursorrules`.

**One-off (no Gemfile)**

```bash
bundle exec rails runner 'MemoryBank::CLI.run("init")'
```

> Useful in sandboxes or CI steps, but the gem install is recommended.

---

## 🎮 Usage

### Supported Development Environments

**Built-in Rails Guides**

* 🌐 **Rails Web** – MVC, Turbo/Stimulus, Hotwire workflows
* 🧱 **Rails API** – API-only, serializers, auth patterns
* 🔌 **Background Jobs** – ActiveJob/Sidekiq patterns

**Custom Guides**

* 🔧 **Company Standards** – your internal conventions and checklists
* 🧩 **Team Workflows** – squad-specific processes and release rituals
* 🏗 **Architecture Patterns** – service objects, DDD, microservices boundary notes

Each guide provides:

* Customized development guidelines and best practices
* Architecture patterns tailored to Rails projects
* Optional `.cursorrules` and RuboCop base config
* Documentation templates for fast onboarding

---

## ⚡ Quick Start

From your Rails app:

```bash
cd your-rails-app
rails g memory_bank:install
```

Choose a development environment when prompted:

```
🚀 Memory Bank Initializer (Rails)
=================================

📝 Available development guides:
  1) 📦 Rails Web - MVC/Turbo/Stimulus
  2) 📦 Rails API - API-only patterns
  3) 📦 Background Jobs - ActiveJob/Sidekiq
  4) 🔧 Company Rails (Custom)
  5) 🔧 Microservices (Custom)

? What type of memory bank would you like to install?
> Rails Web - MVC/Turbo/Stimulus
  Rails API - API-only patterns
  Background Jobs - ActiveJob/Sidekiq
  Company Rails (Custom)
  Microservices (Custom)
```

Or run the task directly:

```bash
rake memory_bank:init
```

---

## 📁 Project Structure

After initialization, you’ll see:

```
your-rails-app/
├─ .memory_bank/                 # AI memory & docs system
│  └─ developmentGuide.md        # Copied from selected guide
├─ .specs/                       # Feature specs (empty initially)
├─ .cursorrules                  # Optional IDE rules (from guide)
└─ config/memory_bank.yml        # Memory Bank configuration
```

> You can expand `.memory_bank/` with more docs as your project grows.

---

## 🧠 Creating Memory Bank Files

Initialize the full docs suite:

```bash
rake memory_bank:initialize
```

This creates:

* `projectBrief.md` – foundation and goals
* `productContext.md` – product vision & UX
* `activeContext.md` – current focus & decisions
* `systemPatterns.md` – architecture & patterns
* `techContext.md` – stack & tooling
* `progress.md` – status, milestones, known issues

---

## 📋 SPEC-Driven Feature Development

Generate a new SPEC:

```bash
rake memory_bank:spec:new FEATURE="export-memory-bank-to-json"
```

This produces:

```
.specs/
└─ export-memory-bank-to-json/
   ├─ requirements.md   # user stories & acceptance criteria
   ├─ design.md         # architecture & component design
   └─ tasks.md          # actionable tasks & checklist
```

**Workflow**

1. **Requirements** – capture stories and acceptance criteria
2. **Design** – choose patterns, boundaries, data flow
3. **Tasks** – break down implementation; track progress

---

## 🧠 Memory Bank System

**Core Components**

* **Project Brief** – scope and success criteria
* **Product Context** – UX goals and problem framing
* **Active Context** – what changed; what’s next
* **System Patterns** – shared decisions & tradeoffs
* **Tech Context** – runtime, deps, CI/CD, linting
* **Progress** – done/blocked/backlog transparency

**Benefits**

* Consistent context for AI agents & humans
* Durable knowledge retention and onboarding
* Fewer regressions; clearer decisions trail

---

## 🔧 Custom Development Guides

Point the engine to your guide folder and manage entries:

```bash
rails memory_bank:configure
```

You’ll be prompted for a directory (can be outside the repo):

```
~/custom-dev-guides/
├─ company-rails/
│  ├─ developmentGuide.md
│  └─ .cursorrules        # optional
├─ microservices/
│  ├─ developmentGuide.md
│  └─ .cursorrules        # optional
└─ legacy-ruby/
   ├─ developmentGuide.md
   └─ .cursorrules        # optional
```

**Required files**

* `developmentGuide.md` – your standards & practices
* `.cursorrules` (optional) – IDE/agent hints

You can also set the folder in `config/memory_bank.yml`:

```yml
memory_bank:
  guides_path: "~/custom-dev-guides"
  default_guide: "company-rails"
```

---

## 🔧 Development (for contributors to the gem)

**Prerequisites**

* Ruby 3.1+
* Rails 7.0+
* Bundler

**Local setup**

```bash
git clone https://github.com/your-org/memory_bank_rails.git
cd memory_bank_rails
bundle install

# run specs
bundle exec rspec

# lint
bundle exec rubocop

# run in a dummy Rails app (engine test)
bin/rails app:template LOCATION=spec/dummy/template.rb
```

**Common scripts**

* `rspec` – run test suite
* `rubocop` – lint/fix
* `rake build` – build gem
* `rake release` – release to RubyGems (maintainers)

---

## 🧪 Testing in Your App

If you track process quality in CI:

```bash
# Verify docs exist
rake memory_bank:check

# Generate coverage report for tasks completeness (optional)
rake memory_bank:report
```

---

## 🤝 Contributing

1. Fork
2. Create a feature branch
3. Add tests
4. Ensure `rspec` and `rubocop` pass
5. Open a PR

---

## 📄 License

MIT. See `LICENSE`.

---

## 💬 Support

* Issues: GitHub Issues
* Discussions: GitHub Discussions

---

## 🙏 Acknowledgments

Inspired by community work on AI agent memory systems, SPEC-driven workflows, and IDE collaboration patterns. Thanks to the Rails and broader AI developer communities for pushing the craft forward.

---

### Appendix: Example `developmentGuide.md` (Company Rails)

```md
# Company Rails Development Guide

## Overview
This guide documents our Rails standards and best practices.

## Coding Standards
- Prefer service objects and form objects for complex flows
- Strong Parameters; avoid mass assignment in models
- RuboCop + Standard enforcement in CI

## Architecture Patterns
- CQRS for complex read models
- Background jobs for non-HTTP work
- Clear boundaries for external integrations

## Best Practices
- RSpec + FactoryBot + Faker
- System specs for critical user flows
- Conventional commits and trunk-based development
```
