# frozen_string_literal: true

require "bundler/audit/task"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "yard-junk/rake"

Bundler::Audit::Task.new
YardJunk::Rake.define_task

task default: %i[test lint]
task test: %i[test:spec]
task lint: %i[lint:all]

namespace :test do
  RSpec::Core::RakeTask.new(:spec)

  RSpec::Core::RakeTask.new(:coverage) do |t|
    t.rspec_opts = "--require simplecov"
  end
end

namespace :lint do
  desc "Verifies code style and quality with `standard` gem"
  task code: %i[standard]

  desc "Check dependencies with bundle-audit"
  task deps: %i[bundle:audit]

  desc "Validate documentation with yard-junk"
  task docs: %i[yard:junk]

  desc "Run all code quality checks"
  task all: %i[code deps docs]
end
