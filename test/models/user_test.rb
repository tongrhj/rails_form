require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@email.com",
                     password: "password", password_confirmation: "password")
  end

  test "User should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should not be blank" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid emails should be accepted" do
    @valid_emails = %w[jxlqk4815@gmail.com A-Us-Er@example.jp first.8.15.16@bai.cn length+last@foo.bar.org]
    @valid_emails.each do |valid_email|
      @user_email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

  test "invalid emails should be rejected" do
    @invalid_emails = %w[jxlqk4815_at_gmail.com A-Us-Er@example,jp first.example@b_ai.cn length+last@foo+bar.org]
    @invalid_emails.each do |invalid_email|
      @user_email = invalid_email
      assert @user.valid?, "#{invalid_email.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
