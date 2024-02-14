require "test_helper"

class ReviseAuth::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :bob
  end

  test "users should be able to sign up" do
    assert_changes -> { User.count } do
      post sign_up_path, params: {user: {email: "new-email@example.com", password: "password1234", password_confirmation: "password1234"}}
    end
  end

  test "shouldn't set first and last name if sign_up_params is not defined" do
    assert_changes -> { User.count } do
      post sign_up_path, params: {user: {email: "new-email@example.com", password: "password1234", password_confirmation: "password1234"}}
    end
    user = User.last
    assert_nil user.first_name
    assert_nil user.last_name
  end

  test "should set first and last name if sign_up_params is defined" do
    ::ApplicationController.define_method :sign_up_params do
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    assert_changes -> { User.count } do
      post sign_up_path, params: {user: {email: "new-email@example.com", password: "password1234", password_confirmation: "password1234", first_name: "John", last_name: "Lennon"}}
    end
    user = User.last
    assert_equal "John", user.first_name
    assert_equal "Lennon", user.last_name
    ::ApplicationController.undef_method :sign_up_params
  end

  test "users should be able to update their account" do
    patch profile_path
    assert_response :redirect
  end

  test "should set first and last name if profile_params is defined" do
    ::ApplicationController.define_method :profile_params do
      params.require(:user).permit(:first_name, :last_name)
    end
    login @user
    patch profile_path, params: {user: {first_name: "John", last_name: "Lennon"}}
    assert_equal "John", @user.reload.first_name
    assert_equal "Lennon", @user.last_name
    ::ApplicationController.undef_method :profile_params
  end

  test "users should be able to delete their account" do
    login @user
    assert_changes -> { User.count } do
      delete profile_path
    end
  end
end
