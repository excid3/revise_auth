ENV["JETS_TEST"] = "1"
ENV["JETS_ENV"] ||= "test"
# Ensures aws api never called. Fixture home folder does not contain ~/.aws/credentails
ENV["HOME"] = "spec/fixtures/home"

require "byebug"
require "fileutils"
require "jets"

abort("The Jets environment is running in production mode!") if Jets.env == "production"
Jets.boot

require "jets/spec_helpers"

require "capybara/rspec"
Capybara.app = Jets.application
# Capybara.current_driver = :selenium
# Capybara.app_host = 'http://localhost:8888'

module Helpers
  def payload(name)
    JSON.parse(IO.read("spec/fixtures/payloads/#{name}.json"))
  end
end

RSpec.configure do |c|
  c.expect_with :minitest
  c.include Helpers
end
