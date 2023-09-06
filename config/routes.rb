Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
    resources :categories
  end
  resources :categories
  resources :products
  
  root "products#index"
end
