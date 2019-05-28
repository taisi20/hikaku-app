Rails.application.routes.draw do
  root to: "histories#index"
  
  get "search", to: "items#search"
  resources :histories, only: [:index, :create]
end
