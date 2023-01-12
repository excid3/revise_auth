module ReviseAuth
  class Current < ActiveSupport::CurrentAttributes
    # Stores the current user for the request
    attribute :user
  end
end
