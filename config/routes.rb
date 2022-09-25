# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notifications/index'
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               registrations: 'users/registrations',
               confirmations: 'users/confirmations',
               omniauth_callbacks: 'users/omniauth_callbacks',
               invitations: 'users/invitations'
             }

  resources :links do
    member do
      get :scan
      get :confirm_destroy
      get :archive
      get :remove_password
    end
  end
  resources :styles
  resources :users, except: %i[index new]
  resources :organizations, only: %i[update]
  resources :notifications, only: :index
  resources :public_pages
  resources :scans, only: :index
  namespace :settings do
    get :profile
    get :organization
    get :developer
  end
  get :marketing, to: 'marketing#index'
  get 'terms-of-service', to: 'marketing#terms_of_service'
  resources :paddle_webhooks, only: :create
  resources :subscription_payments, only: %i[index create]
  resources :subscriptions, except: %i[show]

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
        resources :links, except: %i[new edit]
        resources :styles, only: %i[index show]
        resources :users, only: %i[show update destroy]
      end
    end
  end

  get 'docs', to: 'docs#welcome'
  get 'docs/welcome', to: 'docs#welcome'
  get 'docs/getting-started/register', to: 'docs#register'
  get 'docs/getting-started/create-link', to: 'docs#create_link'

  get '404', to: 'application#page_not_found' if Rails.env.production?
end
