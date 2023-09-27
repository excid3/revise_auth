class Admin::DashboardController < AdminController
  def show
    @users = User.all
  end
end
