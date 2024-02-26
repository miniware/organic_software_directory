Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth
  resources :users, except: [:index, :new, :destroy]

  resources :listings, except: [:new, :destroy, :index] do
    resources :comments, only: :create, module: :listings
  end

  resources :comments, except: [:create, :index] do
    resources :comments, only: :create, module: :comments
  end

  root "listings#index"
end
