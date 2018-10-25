Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index]
  resources :users, only: [:new, :create, :show]
end
