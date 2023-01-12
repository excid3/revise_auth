module ReviseAuth
  module Authentication
    # Provides methods for controllers and views for authentication
    #
    extend ActiveSupport::Concern

    included do
      helper_method :user_signed_in?
      helper_method :current_user
    end

    # Returns a boolean whether the user is signed in or not
    def user_signed_in?
      !!current_user
    end

    # Authenticates the user if not already authenticated
    # Returns a User or nil
    def current_user
      Current.user ||= authenticate_user
    end

    # Authenticates a user or redirects to the login page
    def authenticate_user!
      redirect_to login_path, alert: I18n.t("revise_auth.sign_up_or_login") unless user_signed_in?
    end

    # Authenticates the current user
    # - from session cookie
    # - (future) from Authorization header
    def authenticate_user
      Current.user = authenticated_user_from_session
    end

    # Returns a user from session cookie
    def authenticated_user_from_session
      user_id = request.session[:user_id]
      return unless user_id
      User.find_by(id: user_id)
    end

    # Logs in the user
    # - Set Current.user for the current request
    # - Save a session cookie so the next request is authenticated
    def login(user)
      Current.user = user
      session[:user_id] = user.id
    end

    def logout
      Current.user = nil
      session.delete(:user_id)
    end
  end
end
