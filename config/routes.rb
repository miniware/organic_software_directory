Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth

  concern :votable do
    resource :vote, only: [:create, :destroy]
  end

  get "/@:id", to: "users#show", as: :user
  get "/@:id/settings", to: "users#edit", as: :edit_user
  patch "/@:id", to: "users#update", as: :update_user
  resources :users, only: [:new, :create]

  get "/invites/:token/accept", to: "invites#accept", as: :accept_invite
  resources :invites, only: [:index, :new, :create]

  resources :listings, concerns: :votable, except: [:new, :destroy, :index] do
    resources :comments, only: :create, module: :listings
  end

  resources :comments, concerns: :votable, except: [:create, :index] do
    resources :comments, only: :create, module: :comments
  end


  root "listings#index"
end