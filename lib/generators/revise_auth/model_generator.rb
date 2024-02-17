module ReviseAuth
  module Generators
    class ModelGenerator < Rails::Generators::Base
      desc "Generates the User model for authentication"

      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
      hook_for :orm, required: true, desc: "ORM to be invoked" do |instance, model|
        instance.invoke model, [ "User", "email:string:uniq", "password_digest:string", "confirmed_at:datetime", "unconfirmed_email:string", *instance.attributes ]
      end

      def change_attributes_null
        return unless behavior == :invoke
        gsub_file migration_path, /t\.string :email$/, "t.string :email, null: false"
        gsub_file migration_path, /t\.string :password_digest$/, "t.string :password_digest, null: false"
      end

      def add_revise_auth_model
        inject_into_class "app/models/user.rb", "User", "  include ReviseAuth::Model\n" if behavior == :invoke
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
    end
  end
end
