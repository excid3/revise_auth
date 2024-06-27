require "test_helper"

class ReviseAuth::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get sign_up_url
    assert_response :success
  end

  test "registration failure with existing email" do
    post sign_up_url, params: {user: {email: User.first.email, password: "password1234", password_confirmation: "password1234"}}
    assert_response :unprocessable_entity
  end

  test "registration failure with short password" do
    post sign_up_url, params: {user: {email: "new@user.com", password: "short", password_confirmation: "short"}}
    assert_response :unprocessable_entity
  end

  test "redirects to root path after successful registration" do
    post sign_up_url, params: {user: {email: "new@user.com", password: "password1234", password_confirmation: "password1234"}}
    assert_redirected_to root_path
  end

  test "redirects to stashed location after successful registration" do
    get settings_path
    post sign_up_url, params: {user: {email: "new@user.com", password: "password1234", password_confirmation: "password1234"}}
    assert_redirected_to settings_path
  end

  test "can override after_register_path in ApplicationController" do
    ::ApplicationController.define_method(:after_register_path) { "/pricing" }
    post sign_up_url, params: {user: {email: "new@user.com", password: "password1234", password_confirmation: "password1234"}}
    assert_redirected_to "/pricing"
  ensure
    ::ApplicationController.undef_method(:after_register_path)
  end

  test "redirects if already logged in" do
    post login_url, params: {email: "bob@bob.com", password: "password"}

    get login_url
    assert_redirected_to root_path
    assert_equal I18n.t("revise_auth.shared.already_authenticated"), flash[:alert]

    post login_url, params: {email: "bob@bob.com", password: "password"}
    assert_redirected_to root_path
    assert_equal I18n.t("revise_auth.shared.already_authenticated"), flash[:alert]
  end
end
