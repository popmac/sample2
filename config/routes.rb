Rails.application.routes.draw do
  resources :products
  resources :withdrawals
  root 'products#index'
end
