class AdminController < ReviseAuthController
  layout "admin_application"
  before_action :authenticate_admin
  before_action :gravatar_url

  def authenticate_admin
    redirect_to "/", alert: "Not authorized." unless current_user&.admin?
  end

  def gravatar_url
    options = {}
    hash = Digest::MD5.hexdigest(current_user.email&.downcase || "")
    options.reverse_merge!(default: :mp, rating: :pg, size: 48)
    @grav = "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end
