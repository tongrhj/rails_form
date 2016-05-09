require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  def setup
    @base_title = "ReferralCandy"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
