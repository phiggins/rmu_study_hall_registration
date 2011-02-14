require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

task :test_env do
  RACK_ENV = ENV["RACK_ENV"] = "test"
end

task :test => [:test_env, "db:clean", "db:migrate"]

task :default => :test

task :environment do
  require File.join(File.dirname(__FILE__), %w[ config env ])
end

namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migrator.migrate("lib/migrations")
  end

  task :clean do
    rm "study_hall_#{RACK_ENV}.sqlite3"
  end
end
