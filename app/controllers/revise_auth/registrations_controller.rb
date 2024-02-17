class ReviseAuth::RegistrationsController < ReviseAuthController
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      login(@user)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: t(".account_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    logout
    redirect_to root_path, status: :see_other, alert: t(".account_deleted")
  end

  private

  def sign_up_params
    params.require(:user).permit(ReviseAuth.sign_up_params)
  end

  def profile_params
    params.require(:user).permit(ReviseAuth.update_params)
  end
end
