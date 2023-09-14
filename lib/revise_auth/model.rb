module ReviseAuth
  module Model
    extend ActiveSupport::Concern

    included do
      include Backports

      EMAIL_VERIFICATION_TOKEN_VALIDITY = 1.day

      has_secure_password
      has_secure_token :confirmation_token

      def generate_token_for
        signed_id expires_in: EMAIL_VERIFICATION_TOKEN_VALIDITY, purpose: :email_verification
      end

      validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
      validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP}, allow_blank: true
      validates_length_of :password, minimum: 6, allow_nil: true

      before_validation do
        email&.downcase!&.strip!
        unconfirmed_email&.downcase!
      end
    end

    # Generates a confirmation token and send email to the user
    def send_confirmation_instructions
      token = generate_token_for
      ReviseAuth::Mailer.with(user: self.unconfirmed_email, token: token).confirm_email.deliver_later
    end

    def confirm_email_change
      update(confirmed_at: Time.current, email: unconfirmed_email)
    end
  end
end
