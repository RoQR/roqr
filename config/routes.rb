Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions', passwords: 'user/passwords', registrations: 'user/registrations', confirmations: 'user/confirmations' }

  resources :links do
    get :scan, on: :member
  end
  resources :users, except: [:index, :new]
  resources :events, only: :index
  resources :url_links, except: :index
  resources :email_links, except: :index
  resources :wifi_links, except: :index
  get :marketing, to: 'marketing#index'

  authenticated :user do
    root to: 'links#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: 'marketing#index'
  end

  if Rails.env.production?
    get '404', to: 'application#page_not_found'
  end
end
