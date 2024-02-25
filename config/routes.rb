Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth
  resources :users, except: [:index, :destroy]
  resources :listings, except: [:new, :destroy]

  root "listings#index"
end
