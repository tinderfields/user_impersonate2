#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

require File.expand_path('../test/test_utils', __FILE__)

puts "Testing against Rails #{TestUtils.rails_version} with dummy application in #{TestUtils.dummy_app_dir}"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TinderfieldsUserImpersonate'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/#{TestUtils.dummy_app_dir}/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :cucumber => 'app:cucumber'
# task :default => [:test, :spec, :cucumber]
task :default => [:test, :cucumber]
