Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth
  resources :users, except: [:index, :new, :destroy]

  resources :comments, only: [:edit, :update, :destoy]
  resources :listings, except: [:new, :destroy, :index] do
    resources :comments, shallow: true do
      resources :comments, shallow: true
    end
  end

  root "listings#index"
end
