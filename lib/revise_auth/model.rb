module ReviseAuth
  module Model
    extend ActiveSupport::Concern

    included do |base|
      base.const_set :EMAIL_VERIFICATION_TOKEN_VALIDITY, 1.day
      base.const_set :PASSWORD_RESET_TOKEN_VALIDITY, 1.hour

      has_secure_password

      generates_token_for :password_reset, expires_in: base.const_get(:PASSWORD_RESET_TOKEN_VALIDITY) do
        BCrypt::Password.new(password_digest).salt[-10..]
      end

      generates_token_for :email_verification, expires_in: base.const_get(:EMAIL_VERIFICATION_TOKEN_VALIDITY) do
        email
      end

      normalizes :email, with: -> { _1.strip.downcase }
      normalizes :unconfirmed_email, with: -> { _1.strip.downcase }

      validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
      validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP}, allow_blank: true
      validates_length_of :password, minimum: 12, allow_nil: true
    end

    # Generates a confirmation token and send email to the user
    def send_confirmation_instructions
      token = generate_token_for(:email_verification)
      ReviseAuth::Mailer.with(user: self, token: token).confirm_email.deliver_later
    end

    # Generates a password reset token and send email to the user
    def send_password_reset_instructions
      token = generate_token_for(:password_reset)
      ReviseAuth::Mailer.with(user: self, token: token).password_reset.deliver_later
    end

    def confirm_email_change
      update(confirmed_at: Time.current, email: unconfirmed_email, unconfirmed_email: nil)
    end
  end
end
