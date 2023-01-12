module ReviseAuth
  class RouteConstraint
    attr_reader :request

    # Stub out helper_method
    def self.helper_method(...); end

    include Authentication

    def initialize(request)
      @request = request
    end
  end
end
