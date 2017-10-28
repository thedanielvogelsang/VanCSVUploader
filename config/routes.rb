Rails.application.routes.draw do

  get '/login', as: :login, to: 'sessions#new'

  get 'sessions/create'

  get 'sessions/destroy'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'

  get '/sign-up', as: :new_user, to: 'users#new'
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'
  resources :users, only: [:create]
end
