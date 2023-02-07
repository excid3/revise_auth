Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  revise_auth
  get :authenticated, to: "main#authenticated"

  # Defines the root path route ("/")
  root "main#index"
end
