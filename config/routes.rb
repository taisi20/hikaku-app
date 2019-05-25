Rails.application.routes.draw do
  resources :histories, only: [:index, :new, :create]
end
