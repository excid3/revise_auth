class ReviseAuth::Mailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    @token = params[:token]
    @url = "?confirmation_token=" + @token

    mail to: @user
  end
end
