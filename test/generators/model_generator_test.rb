require "test_helper"
require "generators/revise_auth/model_generator"

class ModelGeneratorTest < Rails::Generators::TestCase
  tests ::ReviseAuth::Generators::ModelGenerator

  destination Rails.root

  test "model and migration are created" do
    run_generator
    assert_file "app/models/user.rb", /include/
    assert_migration "db/migrate/create_users.rb", /def change/
  end

  test "migration is created with user attributes" do
    run_generator ["first_name:string", "last_name:string", "admin:boolean"]
    assert_migration "db/migrate/create_users.rb", /t\.string :first_name/
    assert_migration "db/migrate/create_users.rb", /t\.string :last_name/
    assert_migration "db/migrate/create_users.rb", /t\.boolean :admin/
  end

  test "revise_auth is added to config/routes.rb" do
    run_generator
    assert_file "config/routes.rb", /revise_auth/
  end
end
