Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth

  get "/@:id", to: "users#show", as: :user
  get "/@:id/settings", to: "users#edit", as: :edit_user
  resources :users, only: [:new, :create, :update]

  resources :listings, except: [:new, :destroy, :index] do
    resources :comments, only: :create, module: :listings
  end

  resources :comments, except: [:create, :index] do
    resources :comments, only: :create, module: :comments
  end

  root "listings#index"
end
