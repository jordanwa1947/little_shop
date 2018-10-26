Rails.application.routes.draw do

  root "welcome#show"

  resources :items, only: [:index]

  resources :orders, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  

  resources :users, only: [:new, :create, :edit, :update]

<<<<<<< HEAD

=======
>>>>>>> f9beacf9c3603b01adb9101033c1fb04321a6b82
end
