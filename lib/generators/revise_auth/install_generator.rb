
module ReviseAuth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Install revise_auth"

      source_root File.expand_path("templates", __dir__)

      def copy_migration_file
        migration_template "migration.rb", "db/migrate/create_users.rb"
      end

      def copy_model_file
        template "user.rb", "app/models/user.rb"
      end

      private

      def self.next_migration_number(path)
        @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
      end
    end
  end
end
