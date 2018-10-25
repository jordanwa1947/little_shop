Rails.application.routes.draw do

root "welcome#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :items 
end
