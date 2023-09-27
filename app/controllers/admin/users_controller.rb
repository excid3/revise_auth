class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :destroy, :switch]

  def index
    @users = User.all
  end

  # GET /accounts/1
  def show
    @tokens = @user.api_tokens
  end

  def create
  end

  def update
    @user = User.find(params[:user][:id])
    email = @user.email
    @user.update(email_params)
    if email != params[:user][:unconfirmed_email]
      @user.confirmation_sent_at = Time.now
      @user.save
      @user.send_confirmation_instructions
      # flash[:notice] = I18n.t("revise_auth.confirmation_email_sent", email: current_user.unconfirmed_email)
    end
    redirect_back(fallback_location: root_path)
  end

  # GET /accounts/new
  def new
    @user = User.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # DELETE /accounts/1
  def delete
    ApiToken.find_by(token: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def email_params
    params.require(:user).permit(:first_name, :last_name, :unconfirmed_email)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
