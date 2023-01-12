module ReviseAuth
  module Model
    extend ActiveSupport::Concern

    included do
      has_secure_password
      has_secure_token :confirmation_token

      validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
      validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP}, allow_blank: true

      before_save do
        self.email = email.downcase
        self.unconfirmed_email = unconfirmed_email&.downcase
      end
    end

    # Generates a confirmation token and send email to the user
    def send_confirmation_instructions
      update!(
        confirmation_token: self.class.generate_unique_secure_token(length: ActiveRecord::SecureToken::MINIMUM_TOKEN_LENGTH),
        confirmation_sent_at: Time.current
      )
      ReviseAuth::Mailer.with(user: self).confirm_email.deliver_later
    end

    # Confirms an email address change
    def confirm_email_change
      if confirmation_period_expired?
        false
      else
        update(
          confirmed_at: Time.current,
          email: unconfirmed_email,
          unconfirmed_email: nil
        )
      end
    end

    # Checks whether the confirmation token is within the valid time
    def confirmation_period_expired?
      confirmation_sent_at.before?(1.day.ago)
    end
  end
end
