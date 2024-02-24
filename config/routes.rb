Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, except: [:index, :destroy]
  resources :listings, except: [:destroy]

  root "listings#index"
end
