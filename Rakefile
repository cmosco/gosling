require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'


Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_spec.rb'
end
task :spec

RSpec::Core::RakeTask.new(:webdriver) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_wd.rb'
end
task :webdriver

task :default => :test