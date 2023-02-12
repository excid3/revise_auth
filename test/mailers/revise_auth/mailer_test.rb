require "test_helper"
class ReviseAuth::MailerTest < ActionMailer::TestCase
  test "password_reset" do
    user = users(:bob)
    token = "s3c3tt0k3n"
    email = ReviseAuth::Mailer.with(user:, token:).password_reset

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [user.email], email.to
    assert_includes email.body.to_s, token
  end
end
