require 'rake/clean'
require 'bundler/gem_helper'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs = ['lib']
    t.test_files = FileList['test/unit/*_test.rb']
    t.warning = true
  end

  Rake::TestTask.new(:end_to_end) do |t|
    t.libs = ['lib']
    t.test_files = FileList['test/end_to_end/*_test.rb']
    t.warning = true
  end

  task :all => [:unit, :end_to_end]
end

task :test => 'test:all'

task :default => 'test'
