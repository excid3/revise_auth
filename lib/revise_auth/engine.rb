module ReviseAuth
  class Engine < ::Rails::Engine
    initializer "revise_auth.controller" do
      ActiveSupport.on_load(:action_controller_base) do
        include ReviseAuth::Authentication
      end
    end
  end
end
