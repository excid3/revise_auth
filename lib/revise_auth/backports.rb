module ReviseAuth
  module Backports
    extend ActiveSupport::Concern

    class_methods do
      # Prevent timing-based enumeration attacks.
      # This can be removed when Rails 7.1 is released.
      def authenticate_by(attributes)
        passwords, identifiers = attributes.to_h.partition do |name, value|
          !has_attribute?(name) && has_attribute?("#{name}_digest")
        end.map(&:to_h)

        raise ArgumentError, "One or more password arguments are required" if passwords.empty?
        raise ArgumentError, "One or more finder arguments are required" if identifiers.empty?
        if (record = find_by(identifiers))
          record if passwords.count { |name, value| record.send(:"authenticate_#{name}", value) } == passwords.size
        else
          new(passwords)
          nil
        end
      end
    end
  end
end
