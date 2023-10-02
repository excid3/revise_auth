Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  revise_auth

  constraints ->(request) { ReviseAuth::RouteConstraint.new(request).current_user&.admin? } do
    resource :admin
  end

  constraints ->(request) { ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
    resource :dashboard
  end

  get :authenticated, to: "main#authenticated"
  resources :settings, only: :index

  # Defines the root path route ("/")
  root "main#index"
end
