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
      redirect_to_login_with_stashed_location unless user_signed_in?
    end

    # Authenticates the current user
    # - from session cookie
    # - (future) from Authorization header
    def authenticate_user
      Current.user = authenticated_user_from_session
    end

    # Returns a user from session cookie
    def authenticated_user_from_session
      user_id = session[:user_id]
      return unless user_id
      User.find_by(id: user_id)
    end

    # Logs in the user
    # - Reset the session to prevent session fixation
    #   See: https://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    # - Set Current.user for the current request
    # - Save a session cookie so the next request is authenticated
    def login(user)
      user_return_to = session[:user_return_to]
      reset_session
      Current.user = user
      session[:user_id] = user.id
      session[:user_return_to] = user_return_to
    end

    def logout
      reset_session
      Current.user = nil
    end

    def stash_return_to_location(path)
      session[:user_return_to] = path
    end

    def redirect_to_login_with_stashed_location
      stash_return_to_location(request.fullpath) if request.get?
      redirect_to login_path, alert: I18n.t("revise_auth.sign_up_or_login")
    end

    # Return true if it's a revise_auth_controller. false to all controllers unless
    # the controllers defined inside revise_auth. Useful if you want to apply a before
    # filter to all controllers, except the ones in revise_auth:
    #
    #   before_action :authenticate_user!, unless: :revise_auth_controller?
    def revise_auth_controller?
      is_a?(::ReviseAuthController)
    end
  end
end
