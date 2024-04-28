Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest

  # Defines the root path route ("/")
  root "members#index"

  resources :members, param: :username, except: [:show, :delete]

  get "/join", to: "join#new"
  post "/join", to: "join#create"
  get "/join/confirmation", to: "join#confirmation"

  resources :broadcasts, except: [:show]

  get "/configuration/new", to: "configuration#new"
  post "/configuration", to: "configuration#create"
  patch "/configuration", to: "configuration#update"
  get "/configuration", to: "configuration#edit"

  get "/login", to: "logins#new"
  post "/login", to: "logins#create"
  get "/logout", to: "logins#destroy"

  resources :api_keys, only: [:index, :create, :destroy]

  scope "/api", module: "api" do
    resources :members, param: :username, except: [:new, :edit, :delete]
    resources :broadcasts, except: [:new, :edit, :delete, :update]
  end
end
