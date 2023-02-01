class ReviseAuth::SessionsController < ReviseAuthController
  def new
  end

  def create
    if (user = User.find_by(email: params[:email])&.authenticate(params[:password]))
      login(user)
      redirect_to main_app.root_path
    else
      flash[:alert] = I18n.t("revise_auth.invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to main_app.root_path
  end
end
