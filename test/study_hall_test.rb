ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), %w[ .. config env ]))

require 'test/unit'
require 'rack/test'

class StudyHallTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    StudyHall
  end

  def test_index_redirects
    get '/'
    assert last_response.redirect?
  end

  def test_new_returns_200
    get '/new'
    assert last_response.ok?
  end
end
