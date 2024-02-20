
require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  root "urls#index"

  resources :urls do
    collection do
      delete :delete_all
    end
  end

  get '/dashboard', to: 'urls#show', as: :show_urls
  get '/:short_url', to: 'urls#redirect', as: :short_link


  resources :users


  get "/auth/logout", to: "sessions#destroy"
  get "auth/login", to: "sessions#new"
  post "/auth/login", to: "sessions#create"
  get '/auth/signup', to: 'users#new'
  post "auth/signup", to: "users#create"





  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
