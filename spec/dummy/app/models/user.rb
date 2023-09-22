require "revise_auth-jets"
class User < ApplicationRecord
  has_many :api_tokens, dependent: :destroy
  include ReviseAuth::Model
end
