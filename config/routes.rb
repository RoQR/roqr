Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions', passwords: 'user/passwords', registrations: 'user/registrations' }

  root 'links#index'
  resources :links do
    get :scan, on: :member
  end
  resources :users
  resources :events, only: :index
end
