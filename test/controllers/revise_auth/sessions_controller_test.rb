require "test_helper"

class ReviseAuth::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_url
    assert_response :success
  end

  test "should login with correct credentials" do
    post login_url, params: {email: "bob@bob.com", password: "password"}
    assert_redirected_to root_path
  end

  test "shouldn't login with incorrect password" do
    post login_url, params: {email: "bob@bob.com", password: "wrong_password"}
    assert_response :unprocessable_entity
  end

  test "should logout and reset session" do
    post login_url, params: {email: "bob@bob.com", password: "password"}
    session_id = session.id
    delete logout_url
    assert_not_equal session_id, session.id
  end

  test "stashes path when redirected to login" do
    get settings_path
    assert_redirected_to login_path
    assert_equal settings_path, session[:user_return_to]
  end

  test "redirects to stashed location after successful login" do
    get settings_path
    post login_url, params: {email: "bob@bob.com", password: "password"}
    assert_redirected_to settings_path
  end

  test "can override after_login_path in ApplicationController" do
    ::ApplicationController.define_method(:after_login_path) { "/pricing" }
    post login_url, params: {email: "bob@bob.com", password: "password"}
    assert_redirected_to "/pricing"
  ensure
    ::ApplicationController.undef_method(:after_login_path)
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
