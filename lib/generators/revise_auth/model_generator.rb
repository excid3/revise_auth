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
        model_attributess = model_attributes.join(', ').gsub(':index', '').gsub(',', '')
        puts "jets g model #{name} #{model_attributess}"
        system "jets g model #{name} #{model_attributess}"
        #generate :model, name, *model_attributes
      end

      def add_revise_auth_model
        prepend_to_file model_path, "require 'revise_auth-jets'\n"
        inject_into_class model_path, class_name, "  include ReviseAuth::Model\n"
      end

      def add_uniq_to_email_index
        puts migration_path
        puts name.downcase.pluralize
        insert_into_file migration_path, after: "#{name.downcase.pluralize}, :email", force: true do
          ", unique: true"
        end
      end

      def done
        readme "README" if behavior == :invoke
      end

      private

      def migration_path
        @migration_path ||= Dir.glob(Jets.root.join("db/migrate/*")).max_by { |f| File.mtime(f) }
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def model_attributes
        [
          "email:string:index",
          "password_digest:string",
          "confirmation_token:string",
          "confirmed_at:datetime",
          "confirmation_sent_at:datetime",
          "unconfirmed_email:string"
        ] + @original_attributes
      end
    end
  end
end
