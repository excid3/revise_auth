module ReviseAuth
  module Generators
    class ModelGenerator < Rails::Generators::Base
      desc "Generates the User model for authentication"

      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def initialize(args, *options)
        @original_attributes = args
        super
      end

      def generate_model
        generate :model, "User", *model_attributes
      end

      def change_attributes_null
        insert_into_file migration_path, ", null: false", after: "t.string :email", force: true
        insert_into_file migration_path, ", null: false", after: "t.string :password_digest", force: true
      end

      def add_revise_auth_model
        inject_into_class model_path, "User", "  include ReviseAuth::Model\n"
      end

      def copy_initializer
        template "initializer.rb", "config/initializers/revise_auth.rb"
      end

      def done
        readme "README" if behavior == :invoke
      end

      private

      def migration_path
        @migration_path ||= Dir.glob(Rails.root.join("db/migrate/*")).max_by { |f| File.mtime(f) }
      end

      def model_path
        @model_path ||= File.join("app", "models", "user.rb")
      end

      def model_attributes
        [
          "email:string:uniq",
          "password_digest:string",
          "confirmed_at:datetime",
          "unconfirmed_email:string"
        ] + @original_attributes
      end
    end
  end
end
