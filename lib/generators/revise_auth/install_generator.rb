module ReviseAuth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install revise_auth"

      source_root File.expand_path("templates", __dir__)

      def create_migration_file
        migration_template "migration.rb", "db/migrate/add_users_table.rb"
      end

      def create_model_file
        template "user.rb", "app/models/user.rb"
      end
    end
  end
end
