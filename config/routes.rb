Rails.application.routes.draw do
  root to: "articles#index"
  
  get "search", to: "items#search"
  resources :histories, only: [:index, :create]
  
  resources :articles
  get "ama", to: "articles#amazon"
  
  get "login", to: "sessions#new"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
