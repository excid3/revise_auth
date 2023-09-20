class ReviseAuth::SessionsController < ReviseAuthController
  def new
  end

  def create
    if (user = User.authenticate_by(email: params[:email], password: params[:password]))
      login(user)
      current_user.api_tokens.first_or_create(name: ApiToken::APP_NAME)
      redirect_to root_path
    else
      #flash[:alert] = I18n.t("revise_auth.invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def delete
    logout
    redirect_back(fallback_location: root_path)
  end
end
