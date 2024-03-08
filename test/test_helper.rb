# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
require "rails/test_help"

# Make sure bcrypt is loaded for fixtures
require "bcrypt"

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_paths << File.expand_path("fixtures", __dir__)
ActionDispatch::IntegrationTest.fixture_paths << File.expand_path("fixtures", __dir__)
ActiveSupport::TestCase.fixtures :all

class ActionDispatch::IntegrationTest
  include ReviseAuth::Test::Helpers
end
