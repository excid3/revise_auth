ReviseAuth::Engine.routes.draw do
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  get "profile", to: "registrations#edit"
  patch "profile", to: "registrations#update"
  delete "profile", to: "registrations#destroy"

  patch "profile/email", to: "email#update"
  patch "profile/password", to: "password#update"

  # Email confirmation
  get "profile/email", to: "email#show"

  delete "logout", to: "sessions#destroy"
end
