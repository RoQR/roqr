Rails.application.routes.draw do
  devise_for :users,
             controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations',
                            confirmations: 'users/confirmations', omniauth_callbacks: 'users/omniauth_callbacks', invitations: 'users/invitations' }
  resources :links do
    get :scan, on: :member
    get :confirm_destroy, on: :member
  end
  resources :users, only: %i[show edit create update destroy]
  resources :organizations, only: %i[edit update]
  resources :scans, only: :index
  resources :templates, except: :show
  namespace :settings do
    get :profile, to: 'user'
    get :organization, to: 'organization'
    get :developer, to: 'developer'
  end
  get :plans, to: 'plans#index'
  get :marketing, to: 'marketing#index'

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
        resources :scans, only: :index
        resources :links, only: %i[index create show update destroy]
        resources :templates
        resources :users, only: %i[show update destroy]
      end
    end
  end

  get '404', to: 'application#page_not_found' if Rails.env.production?
end
