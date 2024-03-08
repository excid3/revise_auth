module ReviseAuth
  module Test
    module Helpers
      def login(user, password: "password")
        post login_path, params: {
          email: user.email,
          password: password
        }
      end

      def logout
        delete logout_path
      end
    end
  end
end
