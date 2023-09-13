Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :admin do
    resources :products
    resources :categories
  end

  resources :categories
  resources :products
  resources :carts
  resources :cart_items, only: %i[create update destroy]
  resources :orders, only: %i[index create show new update destroy]
  resources :order_items

  root "products#index"
end
