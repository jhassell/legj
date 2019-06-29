Rails.application.routes.draw do
  resources :assignments
  resources :committees
  resources :members
  root to: 'assignments#index'
  devise_for :users
  resources :users
end
