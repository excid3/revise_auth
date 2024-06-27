class ReviseAuth::SessionsController < ReviseAuthController
  before_action :require_unauthenticated, only: [:new, :create]

  rate_limit(**ReviseAuth.login_rate_limit) if respond_to?(:rate_limit) && ReviseAuth.login_rate_limit.present?

  def new
  end

  def create
    if (user = User.authenticate_by(email: params[:email], password: params[:password]))
      login(user)
      redirect_to resolve_after_login_path
    else
      flash[:alert] = t(".invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
