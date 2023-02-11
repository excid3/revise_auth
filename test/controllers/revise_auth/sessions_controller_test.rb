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
end
