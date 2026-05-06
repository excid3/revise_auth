require "active_support"
require "active_support/core_ext"

require "revise_auth/version"
require "revise_auth/engine"
require "revise_auth/routes"

module ReviseAuth
  autoload :Authentication, "revise_auth/authentication"
  autoload :Current, "revise_auth/current"
  autoload :Model, "revise_auth/model"
  autoload :RouteConstraint, "revise_auth/route_constraint"

  module Test
    autoload :Helpers, "revise_auth/test/helpers"
  end

  def self.configure
    yield self
  end

  mattr_accessor :sign_up_params, default: [:email, :password, :password_confirmation]
  mattr_accessor :update_params, default: []
  mattr_accessor :minimum_password_length, default: 12
  mattr_accessor :login_rate_limit, default: {to: 10, within: 3.minutes, only: :create}
end
