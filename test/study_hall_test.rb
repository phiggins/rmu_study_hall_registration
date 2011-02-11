require 'test_helper'

class StudyHallTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    StudyHall
  end

  def setup
    @create_params = {  :name         => "name", 
                        :email        => "email", 
                        :availability => "anytime", 
                        :subject      => "whatever" }
  end

  def test_index_redirects
    get '/'
    assert last_response.redirect?
  end

  def test_new_returns_200
    get '/new'
    assert last_response.ok?
  end

  def test_create_with_all_params_creates_registration
    reg_count = Registration.count

    post '/create', @create_params
    
    assert_equal Registration.count, reg_count + 1
    assert last_response.ok?
  end

  def test_create_missing_params_does_not_create_registration
    reg_count = Registration.count
    post '/create'
    assert_equal Registration.count, reg_count
  end

  def test_create_missing_name_displays_error
    reg_count = Registration.count
    post '/create', @create_params.delete_if {|k,_| k == :name }
    assert /Name required./ =~ last_response.body, "No error message displayed."
    assert_equal Registration.count, reg_count
  end

  def test_create_missing_email_displays_error
    reg_count = Registration.count
    post '/create', @create_params.delete_if {|k,_| k == :email }
    assert /Email required./ =~ last_response.body, "No error message displayed."
    assert_equal Registration.count, reg_count
  end

  def test_create_missing_availability_displays_error
    reg_count = Registration.count
    post '/create', @create_params.delete_if {|k,_| k == :availability }
    assert /Availability required./ =~ last_response.body, "No error message displayed."
    assert_equal Registration.count, reg_count
  end

  def test_create_missing_subject_displays_error
    reg_count = Registration.count
    post '/create', @create_params.delete_if {|k,_| k == :subject }
    assert /Subject required./ =~ last_response.body, "No error message displayed."
    assert_equal Registration.count, reg_count
  end

  def test_get_to_create_redirects
    reg_count = Registration.count
    get '/create', @create_params
    assert last_response.redirect?
    assert_equal Registration.count, reg_count
  end

  def test_admin_fails_without_authentication
    get '/admin'
    assert_equal 401, last_response.status
  end

  def test_admin_fails_with_bad_credentials
    authorize 'bad', 'boy'
    get '/admin'
    assert_equal 401, last_response.status
  end

  def test_with_proper_credentials
    authorize ADMIN_USER, ADMIN_PASS
    get '/admin'
    assert_equal 200, last_response.status
  end
end
