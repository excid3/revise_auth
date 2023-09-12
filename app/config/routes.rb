Jets.application.routes.draw do
  root "main#index"

  get "authenticated", to: "main#authenticated", as: :authenticated

  scope module: :revise_auth do

    get "sign_up", to: "registrations#new", as: :sign_up
    post "sign_up", to: "registrations#create"
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create"

    get "profile", to: "registrations#edit", as: :profile
    patch "profile", to: "registrations#update"
    delete "profile", to: "registrations#destroy"
    patch "profile/email", to: "email#update"
    get "profile/password", to: "registrations#edit", as: :profile_password
    patch "profile/password", to: "password#update"

    # Email confirmation
    get "profile/email", to: "email#show", as: :profile_email

    delete "logout", to: "sessions#delete"
  end

  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
