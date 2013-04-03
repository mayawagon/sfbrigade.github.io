BrigadeFramework::Application.routes.draw do

  root :to => "home#index"

  # Only admins can create other admins.
  # Devise registrations are disabled, and admins
  # will be created via the admins_controller.
  #
  # Note- devise_for is called outside the :admin namespace
  # intentionally. Nesting it inside namespace has
  # unintended implications for method names in controllers.
  # Instead, use the :path_prefix option.
  devise_for :admins, path_prefix: "admin", skip: [ :registrations ], controllers: {
    sessions: "admin/sessions",
    passwords: "admin/passwords"
  }

  namespace :admin do

    get "/" => "admins#home", as: :home
    get "/admins" => "admins#index"
    get "/admins/new" => "admins#new", as: :new_admin
    post "/admins" => "admins#create"
    delete "/admins/:id" => "admins#destroy", as: :destroy_admin

    resources :brigades
  end

end
