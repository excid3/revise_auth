module ReviseAuth
  class Engine < ::Rails::Engine
    initializer :revise_auth_controller do
      ActiveSupport.on_load(:action_controller_base) do
        include ReviseAuth::Authentication
      end
    end

    # Set default session expiration of 30 days if not specified
    # Runs immediately after Rails defines the default session store
    # https://github.com/rails/rails/blob/7-0-stable/railties/lib/rails/application/finisher.rb#L43-L49
    initializer :revise_auth_cookie_session_expiry, after: :setup_default_session_store do |app|
      if app.config.session_store == ActionDispatch::Session::CookieStore
        app.config.session_options.with_defaults! expire_after: 30.days
      end
    end

    if Rails.gem_version < Gem::Version.new("7.1")
      require "revise_auth/backports/token_for"

      initializer "active_record.generated_token_verifier" do
        config.after_initialize do |app|
          ActiveSupport.on_load(:active_record) do
            self.generated_token_verifier ||= app.message_verifier("active_record/token_for")
          end
        end
      end
    end
  end
end
