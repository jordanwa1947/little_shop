Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index]

  get '/login', to: 'sessions#new'
  #because it's not a resource its being saved in sessions, so we handroll
  post '/login', to: 'sessions#create'
  #trying to follow RESTful conventions

age  resources :users, only: [:new, :create, :show, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
