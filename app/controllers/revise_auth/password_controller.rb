class ReviseAuth::PasswordController < ReviseAuthController
  before_action :validate_current_password, only: [:update]

  def update
    if current_user.update(password_params)
      #flash[:notice] = I18n.t("revise_auth.password_changed")
    end

    redirect_to profile_path
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def validate_current_password
    unless current_user.authenticate(params[:current_password])
      #flash[:alert] = I18n.t("revise_auth.incorrect_password")
      render "revise_auth/registrations/edit", status: :unprocessable_entity
    end
  end
end
