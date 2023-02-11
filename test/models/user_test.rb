require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validations" do
    refute User.new.valid?
  end

  test "password required" do
    user = User.new(email: "test@example.org")
    user.save
    refute_empty user.errors.where(:password, :blank)
  end

  test "email is downcased" do
    user = User.new(email: "TEST@example.org")
    user.valid?
    assert_equal "test@example.org", user.email
  end

  test "email is stripped" do
    user = User.new(email: " \tTEST@example.org ")
    user.valid?
    assert_equal "test@example.org", user.email
  end
end
