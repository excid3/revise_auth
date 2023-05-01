require "test_helper"
class ReviseAuth::EmailControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
  end

  test "changing email should send verification email" do
    login(@user)

    assert_enqueued_emails 1 do
      assert_no_changes -> { @user.reload.email } do
        assert_changes -> { @user.reload.unconfirmed_email } do
          patch profile_email_url, params: {user: {unconfirmed_email: "new-email@email.com"}}
        end
      end
    end
  end

  test "should verify email address" do
    @user.update!(unconfirmed_email: "new-email@email.com")
    token = @user.generate_token_for(:email_verification)

    assert_changes -> { @user.reload.email } do
      get profile_email_url, params: {confirmation_token: token}
    end

    assert_redirected_to root_url
  end

  test "bad token should not verify email address" do
    @user.update!(unconfirmed_email: "new-email@email.com")

    assert_no_changes -> { @user.reload.email } do
      get profile_email_url, params: {confirmation_token: "bad"}
    end

    assert_redirected_to root_url
  end

  test "expired token should not verify email address" do
    @user.update!(unconfirmed_email: "new-email@email.com")
    token = @user.generate_token_for(:email_verification)

    travel User::EMAIL_VERIFICATION_TOKEN_VALIDITY + 1.second

    assert_no_changes -> { @user.reload.email } do
      get profile_email_url, params: {confirmation_token: token}
    end

    assert_redirected_to root_url
  end
end
