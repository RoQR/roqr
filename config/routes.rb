Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions', passwords: 'user/passwords', registrations: 'user/registrations' }
  resources :links do
    get :scan, on: :member
  end
  resources :users
  resources :events, only: :index
  root 'links#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
