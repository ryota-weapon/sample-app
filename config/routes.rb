Rails.application.routes.draw do
  # get 'sessions/new'
  resources :users
  resources :account_acivations, only: [:edit]

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
end

