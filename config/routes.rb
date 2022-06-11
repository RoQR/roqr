Rails.application.routes.draw do
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
