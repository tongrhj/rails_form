require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid user should not be created" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password: "invalid" }
    end
    assert_template 'users/new'
  end

  test "valid user created" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Good Username",
                                            email: "good@email.com",
                                            password: "goodpassword"}
    end
    assert_template 'users/show'
  end
end
