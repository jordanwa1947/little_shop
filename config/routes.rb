Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index]

  resources :orders, only: [:index]

  get '/login', to: 'sessions#new'
  #because it's not a resource its being saved in sessions, so we handroll
  post '/login', to: 'sessions#create'
  #trying to follow RESTful conventions
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'


  resources :users, only: [:new, :create, :edit, :update]

  namespace :admin do
    resources :users, only: [:index, :show, :update]
  end
end
