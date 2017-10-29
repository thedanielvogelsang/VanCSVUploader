Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'

  get '/login', as: :login, to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  get '/sign-up', as: :new_user, to: 'users#new'
  resources :users, only: [:create]

  get '/vanCSV_uploader', as: :csv_loader, to: 'csv_loader#show'
  post '/vanCSV_uploader', as: :uploads, to: 'csv_loader#create'

end
