require "revise_auth/version"
require "revise_auth/engine"
require "revise_auth/routes"

module ReviseAuth
  include ActiveSupport::Configurable

  autoload :Authentication, "revise_auth/authentication"
  autoload :Current, "revise_auth/current"
  autoload :Model, "revise_auth/model"
  autoload :RouteConstraint, "revise_auth/route_constraint"

  module Test
    autoload :Helpers, "revise_auth/test/helpers"
  end

  config_accessor :sign_up_params, default: [:email, :password, :password_confirmation]
  config_accessor :update_params, default: []
  config_accessor :minimum_password_length, default: 12
end
