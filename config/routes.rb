Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :products
  resources :withdrawals
  root 'products#index'
end
