require "test_helper"
class ReviseAuth::PasswordControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
    login(@user)
  end

  test "should reset password" do
    assert_changes -> { @user.reload.password_digest } do
      patch profile_password_url, params: {user: {
        password: "new-password", password_confirmation: "new-password", password_challenge: "password"
      }}
    end

    assert_redirected_to profile_url
  end

  test "should not reset password with missing challenge" do
    assert_no_changes -> { @user.reload.password_digest } do
      patch profile_password_url, params: {user: {
        password: "new-password", password_confirmation: "new-password"
      }}
    end

    assert_response :unprocessable_entity
  end

  test "should not reset password with incorrect challenge" do
    assert_no_changes -> { @user.reload.password_digest } do
      patch profile_password_url, params: {user: {
        password: "new-password", password_confirmation: "new-password", password_challenge: "badpassword"
      }}
    end

    assert_response :unprocessable_entity
  end

  test "should not reset password if new password and password_confirmation do not match" do
    assert_no_changes -> { @user.reload.password_digest } do
      patch profile_password_url, params: {user: {
        password: "new-password", password_confirmation: "mismatched-password", password_challenge: "password"
      }}
    end

    assert_response :unprocessable_entity
  end
end
