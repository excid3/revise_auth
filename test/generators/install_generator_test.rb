require "test_helper"
require "generators/revise_auth/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ReviseAuth::Generators::InstallGenerator

  destination File.expand_path("../../tmp", __dir__)

  setup :prepare_destination

  test "copy migration file" do
    # skip
    run_generator

    assert_migration "db/migrate/create_users.rb"
  end

  test "copy model file" do
    run_generator

    assert_file "app/models/user.rb"
  end
end
