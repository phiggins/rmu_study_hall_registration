require 'test_helper'

class RegistrationTest < Test::Unit::TestCase
  context "Registration" do
    context "on update" do
      test "converts entered string to datetime" do
        reg = Registration.create!  :name         => "foo",
                                    :email        => "foo@foo.foo",
                                    :availability => "anytime",
                                    :subject      => "batman"
        
        assert_nil reg.appointment_at

        s =  "Dec 25th 12:01 am UTC"
        reg.appointment_at = s
        reg.save!
        reg.reload

        assert_equal DateTime.parse(s), reg.appointment_at
      end
    end
  end
end
