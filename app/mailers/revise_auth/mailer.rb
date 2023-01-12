class ReviseAuth::Mailer < ApplicationMailer
  def confirm_email
    mail to: params[:user].unconfirmed_email
  end
end
