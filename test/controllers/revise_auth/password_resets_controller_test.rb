require "test_helper"
class ReviseAuth::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new password page" do
    get new_password_reset_url

    assert_response :success
  end

  test "valid password reset should send an email" do
    assert_enqueued_emails 1 do
      post password_resets_url, params: {user: {email: "bob@bob.com"}}
    end

    assert_redirected_to login_url
  end

  test "invalid password reset should not send an email" do
    assert_no_enqueued_emails do
      post password_resets_url, params: {user: {email: "bad@email.com"}}
    end

    assert_redirected_to login_url
  end

  test "valid password reset links should present a reset form" do
    user = users(:bob)
    token = user.generate_token_for(:password_reset)
    get edit_password_reset_url(token)

    assert_response :success
  end

  test "invalid password reset links should redirect" do
    token = "bad_token"
    get edit_password_reset_url(token)

    assert_redirected_to new_password_reset_url
  end

  test "expired password reset links should redirect" do
    user = users(:bob)
    token = user.generate_token_for(:password_reset)

    travel User::PASSWORD_RESET_TOKEN_VALIDITY + 1.second

    get edit_password_reset_url(token)

    assert_redirected_to new_password_reset_url
  end

  test "should be able to reset password" do
    user = users(:bob)
    token = user.generate_token_for(:password_reset)
    new_password = "my_new_password"

    patch password_reset_url(token), params: {
      user: {password: new_password, password_confirmation: "mismatched_password"}
    }

    assert_response :unprocessable_entity

    patch password_reset_url(token), params: {
      user: {password: new_password, password_confirmation: new_password}
    }

    assert_redirected_to login_url
  end
end
