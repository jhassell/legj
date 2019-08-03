Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/landing'
  get 'home/index'
  get 'home/dashboard'
  resources :assignments
  resources :committees
  resources :members
  root to: 'home#index'
  devise_for :users, controllers: {registrations:'user/registrations'} 
  resources :users

  match "/smartthings", to: "assignments#get_smartthing", via: [:get, :post]

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
end
