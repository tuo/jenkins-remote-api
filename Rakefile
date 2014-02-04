require 'bundler'
require 'rspec/core/rake_task'
require "cucumber/rake/task"

task :default => :test

# Gem Tasks
Bundler::GemHelper.install_tasks

desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
end

desc "Run features"
Cucumber::Rake::Task.new(:features) do |task|
  task.cucumber_opts = ["features"]
end

desc "Run all tests"
task :test => [:spec, :features]