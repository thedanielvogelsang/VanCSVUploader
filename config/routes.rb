Rails.application.routes.draw do
  get 'home/index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
