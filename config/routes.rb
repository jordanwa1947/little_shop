Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index, :show, :edit, :update]

  resource :cart, only: [:create, :show, :destroy, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'

  put '/dashboard/order_items/:id', to: 'dashboard#update', as: :dashboard_order_item
  get '/orders/:id', to: 'orders#show', as: :order
  resources :users, only: [:new, :create, :edit, :update] do
    # get '/profile/orders', to: 'orders#index'
    resources :orders , only: [:create, :index, :show, :update]
  end
  get '/merchants/:merchant_id/orders', to: 'dashboard#index', as: :merchant_orders

  resources :merchants, only: [:index, :show]

  get '/dashboard/orders', to: 'dashboard#index'

 namespace :dashboard do
   resources :items, only: [:index, :new, :create, :update, :show]
 end

  resources :dashboard, only: [:show]

  namespace :admin do
    resources :users, only: [:index, :show, :update] do
      resources :orders, only: [:index, :new]
    end
  end

end
