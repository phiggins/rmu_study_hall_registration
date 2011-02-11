RACK_ENV = ENV["RACK_ENV"] || "development"

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require 'bundler/setup'

require 'sinatra/base'
require 'haml'
require 'sass'
require 'active_record'

require 'logger'

ActiveRecord::Base.logger = Logger.new($stdout)
ActiveRecord::Base.establish_connection(  
  :adapter  => "sqlite3",  
  :database => "study_hall_#{RACK_ENV}.sqlite3")  

lib = File.join(APP_ROOT, "lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'registration'
require 'study_hall'

