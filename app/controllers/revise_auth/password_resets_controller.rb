class ReviseAuth::PasswordResetsController < ReviseAuthController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: user_params[:email])
    user&.send_password_reset_instructions

    flash[:notice] = t(".password_reset_sent")
    redirect_to login_path
  end

  def edit
  end

  def update
    if @user.update(password_params)
      flash[:notice] = t("revise_auth.password.update.password_changed")
      redirect_to login_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by_token_for(:password_reset, params[:token])

    return if @user.present?

    flash[:alert] = t(".invalid_password_link")
    redirect_to new_password_reset_path
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
