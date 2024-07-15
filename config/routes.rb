Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  mount MissionControl::Jobs::Engine, at: "/organization/jobs"
  mount DemoMode::Engine => "/demo"
  mount LetterOpenerWeb::Engine, at: "/organization/letters" if Rails.application.config.action_mailer.delivery_method == :letter_opener

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal healconfig.action_mailer.delivery_method = :letter_openerth status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest

  # Defines the root path route ("/")
  root "my/memberships#new"

  namespace :organization do
    root "members#index", as: :members

    resources :members, param: :username, except: [:index, :edit, :delete] do
      collection do
        resources :exports, only: [:show], param: :type, module: :member
      end
    end

    resources :broadcasts, only: [:index, :destroy, :create]

    resource :config, except: [:edit, :destroy]

    resource :journey, only: [:new, :create] do
      collection do
        resources :strategies, only: [:index], shallow: true, as: "journey_strategies", module: :journey do
          collection do
            scope module: :strategies do
              namespace :password do
                resources :authentications, only: [:new, :create]
              end
              namespace :passkey do
                resources :authentications, only: [:new, :create]
              end
            end
          end
        end
        get "/delete", to: "journeys#delete"
      end
    end

    get "/cemetery", to: "cemeteries#index"
    get "/petitions", to: "petitions#index"

    resources :api_keys, only: [:index, :create, :destroy]

    # TODO: shallow nest inside of Config
    resources :passkeys, only: [:index, :new, :create, :destroy]
  end

  namespace :api do
    resources :members, param: :username, except: [:new, :edit, :delete] do
      member do
        resource :actor, only: :show, module: :member, as: :member_actor, controller: :actors
      end
    end
    resources :broadcasts, except: [:new, :edit, :delete, :update]
  end
  
  namespace :my do
    root to: redirect("/my/membership")

    resource :journey, only: [:new, :create] do
      collection do
        resources :strategies, only: [:index], shallow: true, as: "journey_strategies", module: :journey do
          collection do
            scope module: :strategies do
              namespace :keycode do
                resources :authentications, only: [:new, :create]
              end
              namespace :passkey do
                resources :authentications, only: [:new, :create]
              end
            end
          end
        end
        get "/delete", to: "journeys#delete"
      end
    end

    resource :membership, only: [:new, :create, :show, :update, :destroy] do
      resource :renewals, only: [:create], module: :membership
    end

    namespace :imprint do
      resource :rotations, only: [:create]
    end

    resources :passkeys, only: [:index, :new, :create, :destroy]
  end

  resolve("Membership") { [:membership] }
  resolve("Journey") { [:journey] }
  resolve("Config") { [:config] }
end