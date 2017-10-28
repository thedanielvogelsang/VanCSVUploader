Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'

  get '/login', as: :login, to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  get '/sign-up', as: :new_user, to: 'users#new'
  resources :users, only: [:create]

  get '/vanCSV_uploader', as: :csv_loader, to: 'csv_loader#show'

end
