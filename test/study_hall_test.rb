require 'test_helper'

class StudyHallTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    StudyHall
  end

  context "/" do
    test "redirects" do
      get '/'
      assert last_response.redirect?
    end
  end

  context "/new" do
    test "returns 200" do
      get '/new'
      assert last_response.ok?
    end
  end

  context "/create" do
    setup do
      @create_params = {  :name         => "name", 
                          :email        => "email", 
                          :availability => "anytime", 
                          :subject      => "whatever" }
    end

    context "POST" do
      test "creates a registration with all parameters" do
        reg_count = Registration.count

        post '/create', @create_params
        
        assert_equal Registration.count, reg_count + 1
        assert last_response.ok?
      end

      test "does not create a registration with no parameters" do
        reg_count = Registration.count
        post '/create'
        assert_equal Registration.count, reg_count
      end

      test "displays and error when name is missing" do
        reg_count = Registration.count
        post '/create', @create_params.delete_if {|k,_| k == :name }
        assert /Name required./ =~ last_response.body, "No error message displayed."
        assert_equal Registration.count, reg_count
      end

      test "displays and error when email is missing" do
        reg_count = Registration.count
        post '/create', @create_params.delete_if {|k,_| k == :email }
        assert /Email required./ =~ last_response.body, "No error message displayed."
        assert_equal Registration.count, reg_count
      end

      test "displays and error when availability is missing" do
        reg_count = Registration.count
        post '/create', @create_params.delete_if {|k,_| k == :availability }
        assert /Availability required./ =~ last_response.body, "No error message displayed."
        assert_equal Registration.count, reg_count
      end

      test "displays and error when subject is missing" do
        reg_count = Registration.count
        post '/create', @create_params.delete_if {|k,_| k == :subject }
        assert /Subject required./ =~ last_response.body, "No error message displayed."
        assert_equal Registration.count, reg_count
      end
    end

    context "GET" do
      test "redirects" do
        reg_count = Registration.count
        get '/create', @create_params
        assert last_response.redirect?
        assert_equal Registration.count, reg_count
      end
    end
  end

  context "/admin" do
    test "fails without authentication" do
      get '/admin'
      assert_equal 401, last_response.status
    end

    test "fails with bad credentials" do
      authorize 'bad', 'boy'
      get '/admin'
      assert_equal 401, last_response.status
    end

    test "lists registrations with proper credentials" do
      attrs = [:name, :email, :availability, :subject]

      2.times do |n|
        params = Hash[*attrs.map {|attr| [attr, "#{attr} #{n}" ] }.flatten]

        Registration.create! params
      end
      
      authorize ADMIN_USER, ADMIN_PASS
      get '/admin'
      assert_equal 200, last_response.status

      Registration.all.each do |reg|
        attrs.each do |attr|
          assert last_response.body.include?(reg[attr]),
            "Response body did not include #{attr} for #{reg.inspect}"
        end
      end
    end
  end
end
