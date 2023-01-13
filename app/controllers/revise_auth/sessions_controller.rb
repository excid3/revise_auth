class ReviseAuth::SessionsController < ReviseAuthController
  def new
  end

  def create
    if (user = User.find_by(email: params[:email])&.authenticate(params[:password]))
      after_login_path = session[:user_return_to] || root_path
      login(user)
      redirect_to after_login_path
    else
      flash[:alert] = I18n.t("revise_auth.invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
