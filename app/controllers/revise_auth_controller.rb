class ReviseAuthController < ApplicationController
  def validate_current_password
    unless current_user.authenticate(params[:current_password])
      flash[:alert] = "Your current password is incorrect. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end
end
