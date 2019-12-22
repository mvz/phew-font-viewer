# frozen_string_literal: true

require "rake/clean"
require "bundler/gem_helper"
require "rake/testtask"

Bundler::GemHelper.install_tasks

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs = ["lib"]
    t.test_files = FileList["test/**/*_test.rb"]
    t.warning = true
  end

  Rake::TestTask.new(:features) do |t|
    t.libs = ["lib"]
    t.test_files = FileList["features/**/*_test.rb"]
    t.warning = true
  end

  task all: [:unit, :features]
end

task test: "test:all"

task default: "test"
