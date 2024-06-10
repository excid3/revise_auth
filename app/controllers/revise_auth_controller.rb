class ReviseAuthController < ::ApplicationController
  private

  def return_to_location
    session.delete(:user_return_to)
  end
end
