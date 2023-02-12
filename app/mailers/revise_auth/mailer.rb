class ReviseAuth::Mailer < ApplicationMailer
  def confirm_email
    mail to: params[:user].unconfirmed_email
  end

  def password_reset
    @user = params[:user]
    @token = params[:token]

    mail to: @user.email
  end
end
