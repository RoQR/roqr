# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :subscription_payments
    resources :subscriptions
    resources :styles
    resources :scans
    resources :requests
    resources :public_pages
    resources :organizations
    resources :notifications
    resources :links
    resources :users
    resources :contact_links
    resources :wifi_links
    resources :url_links
    resources :telephone_links
    resources :sms_links
    resources :email_links

    root to: "links#index"
  end
  get "notifications/index"
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      passwords: "users/passwords",
      registrations: "users/registrations",
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks",
      invitations: "users/invitations",
      masquerades: "users/masquerades"
    }
  devise_for :admin_users

  resources :links do
    member do
      get :scan
      get :confirm_destroy
      get :challenge
      post :archive
      post :unarchive
      patch :challenge
      patch :remove_password
    end
  end
  resources :styles
  resources :users, except: %i[index new]
  resources :organizations, only: %i[update] do
    member do
      get :confirm_destroy
    end
  end
  resources :notifications, only: :index
  resources :public_pages
  resources :scans, only: :index
  namespace :settings do
    get :profile
    get :organization
    get :subscription
    get :developer
  end
  get :marketing, to: "marketing#index"
  get "terms-of-service", to: redirect("https://docs.roqr.app/terms-of-service")
  get "privacy-policy", to: redirect("https://docs.roqr.app/privacy-policy")
  resources :paddle_webhooks, only: :create
  resources :subscription_payments, only: %i[index create]
  resources :subscriptions, except: %i[show] do
    patch :preview, on: :member
  end

  authenticated :user do
    root to: "links#index", as: :authenticated_root
  end

  authenticated :admin_user do
    mount Blazer::Engine, at: "blazer"
  end

  devise_scope :user do
    root to: "marketing#index"
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

  get "404", to: "application#page_not_found" if Rails.env.production?
  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?
end
