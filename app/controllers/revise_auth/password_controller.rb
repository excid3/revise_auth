class ReviseAuth::PasswordController < ReviseAuthController
  before_action :authenticate_user!

  def update
    if current_user.update(password_params)
      redirect_to profile_path, notice: I18n.t("revise_auth.password_changed")
    else
      flash[:alert] = I18n.t("revise_auth.incorrect_password")
      render "revise_auth/registrations/edit", status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
