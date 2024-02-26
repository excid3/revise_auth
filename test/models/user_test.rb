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

  test "password meets minimum length" do
    valid_user = User.new(email: "test@example.org")

    # Default minimum password length is 12 characters
    valid_user.password = "a" * 14
    valid_user.valid?
    assert_empty valid_user.errors.where(:password, :too_short)

    # Change minimum password length
    ReviseAuth.minimum_password_length = 16

    # Remove User object and reload file to capture new configuration
    Object.send(:remove_const, :User)
    load Rails.root.join "app/models/user.rb"

    # Recreate the user with the new minimum length validation
    invalid_user = User.new(email: "test@example.org")

    # Minimum password length is now 16 characters (set above in this test)
    invalid_user.password = "a" * 14
    invalid_user.valid?
    refute_empty invalid_user.errors.where(:password, :too_short)

    # Clean up/revert changes to config for additional tests
    ReviseAuth.minimum_password_length = 12
    Object.send(:remove_const, :User)
    load Rails.root.join "app/models/user.rb"
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
