# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :organizations
    resources :users
    resources :links
    resources :styles
    resources :scans
    resources :contact_links
    resources :email_links
    resources :sms_links
    resources :telephone_links
    resources :url_links
    resources :wifi_links
    resources :subscriptions
    resources :subscription_payments
    resources :custom_domains
    resources :notifications
    resources :requests

    root to: "organizations#index"
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
      get :confirm_remove_custom_domain
      post :archive
      post :unarchive
      patch :challenge
      patch :remove_password
      patch :remove_custom_domain
    end
  end
  resources :styles
  resources :users, except: %i[index new]
  resources :organizations, only: %i[update] do
    resources :custom_domains, shallow: true do
      get :check, on: :member
    end
    member do
      get :confirm_destroy
    end
  end
  resources :notifications, only: :index
  resources :scans, only: :index
  namespace :settings do
    get :profile
    get :organization
    get :subscription
    get :developer
  end
  get :marketing, to: "marketing#index"
  namespace :marketing do
    resources :qr
  end
  get "terms-of-service", to: redirect("https://docs.roqr.app/terms-of-service")
  get "privacy-policy", to: redirect("https://docs.roqr.app/privacy-policy")
  resources :paddle_webhooks, only: :create
  resources :subscription_payments, only: %i[index create]
  resources :subscriptions, except: %i[show] do
    get :subscribed, on: :collection
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
    namespace :v1 do
      defaults format: :json do
        resources :links, except: %i[new edit] do
          member do
            post :archive
            post :unarchive
          end
        end
        unless Rails.env.production?
          resources :scans, only: :index
          resources :styles, only: %i[index show]
          resources :users, only: %i[show update destroy]
        end
      end
    end
  end

  resource :flash, only: :create

  resource :github_secret_reports, only: :create

  if Rails.env.production?
    get "404", to: "application#page_not_found"
    get "500", to: "application#internal_error"
  end
  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?
end
