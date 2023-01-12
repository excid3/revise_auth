module ActionDispatch::Routing
  class Mapper
    # Adds helpers for config/routes.rb to constraint routes with authentication

    def authenticated
      constraints ->(request) { ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
        yield
      end
    end

    def unauthenticated
      constraints ->(request) { !ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
        yield
      end
    end
  end
end
