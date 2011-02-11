RACK_ENV = ENV["RACK_ENV"] || "development"

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require 'bundler/setup'

require 'sinatra/base'
require 'haml'
require 'sass'
require 'active_record'

require 'logger'

ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::Base.establish_connection(  
  :adapter  => "sqlite3",  
  :database => "study_hall_#{RACK_ENV}.sqlite3")  

require 'yaml'
creds_file = File.join(APP_ROOT, "config", "admin_creds.yml")

begin
  ADMIN_USER, ADMIN_PASS = 
    YAML.load_file(creds_file).values_at("user", "pass")
rescue
  abort <<ABORT
  
Hey! You need to create an admin credentials file first!
  
It should go here:
#{creds_file}

It should look like this:
#{{:user => "CONFIDENTIAL", :pass => "CONFIDENTIAL"}.to_yaml}

ABORT
end

lib = File.join(APP_ROOT, "lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'registration'
require 'study_hall'
