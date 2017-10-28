Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'

  get '/sign-up', as: :new_user, to: 'users#new'
  resources :users, only: [:create]
end
