Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index, :show]

  # resources :orders, only: [:index]

  resource :carts, only: [:create, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'

  resources :users, only: [:new, :create, :edit, :update]

  resources :merchants, only: [:index, :show]

  namespace :admin do
    resources :users, only: [:index, :show, :update] do
      resources :orders, only: [:index]
    end
  end

end
