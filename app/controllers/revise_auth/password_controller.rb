class ReviseAuth::PasswordController < ReviseAuthController
  before_action :validate_current_password, only: [:update]

  def update
    if current_user.update(password_params)
      flash[:notice] = "Your password has been changed successfully."
    end

    redirect_to profile_path
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
