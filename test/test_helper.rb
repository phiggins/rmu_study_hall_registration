ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), %w[ .. config env ]))

require 'contest'
require 'rack/test'
