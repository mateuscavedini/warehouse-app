Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
