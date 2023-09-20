module ReviseAuth
  module ApiModel
    extend ActiveSupport::Concern

    included do
      DEFAULT_NAME = "api_token"
      APP_NAME = "my_app"

      belongs_to :user

      scope :sorted, -> { order("last_used_at DESC NULLS LAST, created_at DESC") }

      has_secure_token :token

      validates :name, presence: true

      def can?(permission)
        Array.wrap(data("permissions")).include?(permission)
      end

      def cant?(permission)
        !can?(permission)
      end

      def data(key, default: nil)
        (metadata || {}).fetch(key, default)
      end

      def expired?
        expires_at? && Time.current >= expires_at
      end

      def touch_last_used_at
        return if transient?
        update(last_used_at: Time.current)
      end

      def generate_token
        loop do
          self.token = SecureRandom.hex(16)
          break unless ApiToken.where(token: token).exists?
        end
      end
    end
  end
end
