class Api::BaseController < ApplicationController
  include ReviseAuth::Authentication
  skip_before_action :verify_authenticity_token
  prepend_before_action :authenticate_api_token!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def record_not_found
    render json: {error: "Record Not Found"}, status: :not_found
  end

  def handle_parameter_missing(exception)
    render json: {error: exception.message}, status: :bad_request
  end

  def authenticate_api_token!
    if user_from_token
      login(user_from_token)
    else
      render status: :unauthorized, json: {}
    end
  end

  def token_from_header
    request.headers.fetch("authorization", "").split(" ").last
  end

  def api_token
    @_api_token ||= ApiToken.find_by(token: token_from_header)
  end

  # Only for use within authenticate_api_token! above
  # Use current_user/Current.user or current_account/Current.account within app controllers
  def user_from_token
    if api_token.present?
      api_token.touch(:last_used_at)
      api_token.user
    end
  end
end
