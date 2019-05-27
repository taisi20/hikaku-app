Rails.application.routes.draw do
  root to: "histories#index"
  
  resources :items, only: [:new, :create]
  resources :histories, only: [:index, :new, :create]
end
