require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

task :default => :test

task :environment do
  require File.join(File.dirname(__FILE__), %w[ config env ])
end

namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("lib/migrations")
  end
end
