Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
