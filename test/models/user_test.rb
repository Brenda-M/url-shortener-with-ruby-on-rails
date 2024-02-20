require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "user1", email: "user1@example.com", password: "password123")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should not be blank" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "email should not be blank" do
    @user.email = ""
    assert_not @user.valid?
  end

end
