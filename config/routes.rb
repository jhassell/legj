Rails.application.routes.draw do
  resources :assignments
  resources :committees
  resources :members
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
