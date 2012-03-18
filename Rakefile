#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'metric_fu'
MetricFu::Configuration.run do |config|
  config.metrics -= [ :rcov ]
end

JenkinsRailsTest::Application.load_tasks
