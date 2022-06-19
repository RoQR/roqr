Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', confirmations: 'users/confirmations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :links do
    get :scan, on: :member
  end
  resources :users, except: [:index, :new]
  resources :events, only: :index
  resources :contact_links, except: :index
  resources :email_links, except: :index
  resources :sms_links, except: :index
  resources :telephone_links, except: :index
  resources :url_links, except: :index
  resources :wifi_links, except: :index
  get :marketing, to: 'marketing#index'
  get :qr, to: 'qr#show', format: :svg

  authenticated :user do
    root to: 'links#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: 'marketing#index'
  end

  namespace :user do
    resource :private_api_keys, only: :update
  end

  namespace :api do
    namespace :v0 do
      defaults format: :json do
        resources :links, only: [:index, :create, :show, :update, :destroy]
      end
    end
  end

  if Rails.env.production?
    get '404', to: 'application#page_not_found'
  end
end
