Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'

  resources :users, only: [:new, :create, :edit, :update]


end
