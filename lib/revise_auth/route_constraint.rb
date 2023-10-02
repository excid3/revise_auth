module ReviseAuth
  class RouteConstraint
    attr_reader :request

    # Stub out helper_method
    def self.helper_method(...)
    end

    include Authentication

    delegate :session, to: :@request

    def initialize(request)
      @request = request
    end
  end
end
