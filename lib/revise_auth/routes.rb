# module ActionDispatch::Routing
# class Mapper
#   def revise_auth
#     scope module: :revise_auth do
#       revise_registration

#       get "login", to: "sessions#new"
#       post "login", to: "sessions#create"

#       revise_profile

#       patch "profile/email", to: "email#update"
#       patch "profile/password", to: "password#update"

#       # Email confirmation
#       get "profile/email", to: "email#show"

#       delete "logout", to: "sessions#destroy"
#     end
#   end

#   # Adds helpers for config/routes.rb to constraint routes with authentication
#   #
#   def authenticated
#     constraints ->(request) { ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
#       yield
#     end
#   end

#   def unauthenticated
#     constraints ->(request) { !ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
#       yield
#     end
#   end

#   private

#   def revise_registration
#     get "sign_up", to: "registrations#new"
#     post "sign_up", to: "registrations#create"
#   end

#   def revise_profile
#     get "profile", to: "registrations#edit"
#     patch "profile", to: "registrations#update"
#     delete "profile", to: "registrations#destroy"
#   end
# end
# end
