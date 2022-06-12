Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions', passwords: 'user/passwords', registrations: 'user/registrations', confirmations: 'user/confirmations' }

  resources :links do
    get :scan, on: :member
  end
  resources :users
  resources :events, only: :index

  authenticated :user do
    root to: 'links#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: 'user/sessions#new'
  end
end
