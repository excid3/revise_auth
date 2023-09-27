require "test_helper"
class ReviseAuth::MailerTest < ActionMailer::TestCase
  setup do
    @user = users(:bob)
    @token = "s3c3tt0k3n"
  end

  test "password_reset" do
    email = ReviseAuth::Mailer.with(user: @user, token: @token).password_reset

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@user.email], email.to
    assert_includes email.body.to_s, @token
  end

  test "confirm_email" do
    @user.unconfirmed_email = "unconfirmed@email.com"

    email = ReviseAuth::Mailer.with(user: @user, token: @token).confirm_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["unconfirmed@email.com"], email.to
    assert_includes email.body.to_s, @token
  end
end
