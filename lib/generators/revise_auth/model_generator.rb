module ReviseAuth
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      desc "Generates a model for authentication, default User"

      source_root File.expand_path("templates", __dir__)

      argument :name, required: false, default: "User"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def initialize(args, *options)
        @original_attributes = args[1..] || []
        super
      end

      def generate_model
        generate :model, name, *model_attributes
      end

      def add_revise_auth_model
        inject_into_class model_path, class_name, "  include ReviseAuth::Model\n"
      end

      def add_uniq_to_email_index
        insert_into_file migration_path, after: "#{name.downcase.pluralize}, :email", force: true do
          ", unique: true"
        end
      end

      def done
        readme "README" if behavior == :invoke
      end

      private

      def migration_path
        @migration_path ||= Dir.glob(Rails.root.join("db/migrate/*")).max_by { |f| File.mtime(f) }
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def model_attributes
        [
          "email:string:index",
          "password_digest:string",
          "confirmed_at:datetime",
          "unconfirmed_email:string"
        ] + @original_attributes
      end
    end
  end
end
