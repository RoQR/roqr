Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', confirmations: 'users/confirmations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :links do
    get :scan, on: :member
  end
  resources :users, except: [:index, :new]
  resources :events, only: :index
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
        resources :events, only: :index
        resources :links, only: [:index, :create, :show, :update, :destroy]
        resources :users, only: [:show, :update, :destroy]
      end
    end
  end

  if Rails.env.production?
    get '404', to: 'application#page_not_found'
  end
end
