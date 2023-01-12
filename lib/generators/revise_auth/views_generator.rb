require "rails/generators"

module ReviseAuth
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)

      class_option :views, aliases: "-v", type: :array, desc: "Select specific view directories to generate (confirmations, passwords, registrations, sessions, unlocks, mailer)"

      def copy_views
        if options[:views]
          options[:views].each do |directory|
            directory "app/views/revise_auth/#{directory}"
          end
        else
          directory "app/views/revise_auth"
        end
      end
    end
  end
end
