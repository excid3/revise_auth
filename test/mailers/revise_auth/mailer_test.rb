require "test_helper"
class ReviseAuth::MailerTest < ActionMailer::TestCase
  test "confirm_email" do
    user = users(:bob)
    user.unconfirmed_email = "unconfirmed@email.com"
    token = "s3c3tt0k3n"

    email = ReviseAuth::Mailer.with(user:, token:).confirm_email

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["unconfirmed@email.com"], email.to
    assert_includes email.body.to_s, token
  end
end
