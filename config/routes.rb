Rails.application.routes.draw do
  root to: "histories#index"
  get "search", to: "items#search"
  resources :histories, only: [:index, :create]
  
  resources :articles
  
  get "login", to: "sessions#new"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
