Rails.application.routes.draw do
  get "up", to: "rails/health#show", as: :rails_health_check

  passwordless_for :users, at: "/", as: :auth

  concern :votable do
    resource :vote, only: [:create, :destroy]
  end

  concern :commentable do
    resources :comments, only: :create, module: :comments
  end

  get "/@:id", to: "users#show", as: :user
  get "/@:id/settings", to: "users#edit", as: :edit_user
  resources :users, only: [:update, :new, :create]

  get "/invites/:token/accept", to: "invites#accept", as: :accept_invite
  resources :invites, only: [:index, :new, :create]

  resources :listings, concerns: [:votable, :commentable], except: [:new, :destroy, :index]
  resources :comments, concerns: [:votable, :commentable], except: [:create, :index]

  root "listings#index"
end