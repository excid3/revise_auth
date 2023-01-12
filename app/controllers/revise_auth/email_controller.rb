class ReviseAuth::EmailController < ReviseAuthController
  before_action :authenticate_user!, except: [:show]

  # GET /profile/email?confirmation_token=abcdef
  def show
    if User.find_by(confirmation_token: params[:confirmation_token])&.confirm_email_change
      flash[:notice] = "Your email address has been successfully confirmed."
      user_signed_in?
      redirect_to (user_signed_in? ? profile_path : root_path)
    else
      redirect_to root_path, alert: "Unable to confirm email address."
    end
  end

  def update
    if current_user.update(email_params)
      current_user.send_confirmation_instructions
      flash[:notice] = "A confirmation email has been sent to #{current_user.unconfirmed_email}"
    end

    redirect_to profile_path
  end

  private

  def email_params
    params.require(:user).permit(:unconfirmed_email)
  end
end
