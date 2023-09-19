require "rails/generators"

module ReviseAuth
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)

      class_option :views, aliases: "-v", type: :array, desc: "Select specific view directories to generate (confirmations, passwords, registrations, sessions, unlocks, mailer)"

      def copy_config
        template "app/config/routes.rb", "config/routes.rb"
      end

      def copy_styles
        template "app/stylesheet/theme.scss", "app/javascripts/packs"
      end

      def copy_controllers
        template "app/controllers/main_controller.rb", "app/controllers/main_controller.rb"
        template "app/controllers/revise_auth_controller.rb", "app/controllers/revise_auth_controller.rb"
        if options[:controllers]
          options[:controllers].each do |directory|
            directory "app/controllers/revise_auth/#{directory}"
          end
        else
          directory "app/controllers/revise_auth"
        end
      end

      def copy_views
        if options[:views]
          options[:views].each do |directory|
            directory "app/views/revise_auth/#{directory}"
          end
        else
          directory "app/views/revise_auth"
          directory "app/views/main"
        end
      end
    end
  end
end
