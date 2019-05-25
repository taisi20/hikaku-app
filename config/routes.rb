Rails.application.routes.draw do
  root to: "histories#index"
  resources :histories, only: [:index, :new, :create]
end
