Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  # get 'sessions/new'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :update, :edit]
  resources :microposts, only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
  
  root "static_pages#home" 
  
  get  "/home", to: "static_pages#home"
  get  "/about", to: "static_pages#about"
  get  "/help", to: "static_pages#help"
  get  "/contact", to: "static_pages#contact"
  
  # get "/edit", to: "users#edit"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
end

