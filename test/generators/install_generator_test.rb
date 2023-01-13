require "test_helper"
require "generators/revise_auth/model_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ::ReviseAuth::Generators::ModelGenerator

  destination Rails.root

  teardown do
    remove_if_exists("app/models/account.rb")
    remove_if_exists("db/migrate")
    remove_if_exists("test")
  end

  test "model and migration are created" do
    run_generator ["Account"]
    assert_file "app/models/account.rb", /include/
    assert_migration "db/migrate/create_accounts.rb", /def change/
  end

  test "migration is created with user attributes" do
    run_generator ["Account", "first_name:string", "last_name:string"]
    assert_migration "db/migrate/create_accounts.rb", /first_name/
    assert_migration "db/migrate/create_accounts.rb", /last_name/
  end

  def remove_if_exists(path)
    full_path = Rails.root.join(path)
    FileUtils.rm_rf(full_path)
  end
end
