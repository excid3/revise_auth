require "revise_auth-jets"
class ApiToken < ApplicationRecord
  include ReviseAuth::ApiModel
  belongs_to :user
end
