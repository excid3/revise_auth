require "revise_auth/version"
require "revise_auth/engine"
require "revise_auth/routes"

module ReviseAuth
  autoload :Authentication, "revise_auth/authentication"
  autoload :Current, "revise_auth/current"
  autoload :Model, "revise_auth/model"
  autoload :RouteConstraint, "revise_auth/route_constraint"
end
