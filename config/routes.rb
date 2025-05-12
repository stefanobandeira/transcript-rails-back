Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :videos, only: [:create, :index] do
  post :share, on: :member
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Isso permite servir arquivos do ActiveStorage (os vídeos)
  direct :rails_blob do |blob|
    route_for(:rails_service_blob, blob.signed_id, blob.filename)
  end
end
