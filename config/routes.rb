Rails.application.routes.draw do


  get '/login', to: 'sessions#new'
  #because it's not a resource its being saved in sessions, so we handroll
  post '/login', to: 'sessions#create'
  #trying to follow RESTful conventions
end
