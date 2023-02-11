class ReviseAuth::Mailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    @token = params[:token]

    mail to: @user.unconfirmed_email
  end
end
