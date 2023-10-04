require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validations" do
    refute User.new.valid?
  end

  test "can create user" do
    password = "password123456"

    assert_difference "User.count", 1, "could not create a valid user" do
      User.create(email: "test@example.org", password: password, password_confirmation: password)
    end
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

  test "authenticate_by" do
    assert User.respond_to?(:authenticate_by)
  end
end
