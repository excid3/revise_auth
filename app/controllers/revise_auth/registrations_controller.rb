class ReviseAuth::RegistrationsController < ReviseAuthController
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      login(@user)
      current_user.api_tokens.first_or_create(name: ApiToken::APP_NAME)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: I18n.t("revise_auth.account_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    current_user.destroy
    logout
    redirect_to root_path, status: :see_other, alert: I18n.t("revise_auth.account_deleted")
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
