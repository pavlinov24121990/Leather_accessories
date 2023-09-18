Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :admin do
    resources :products
    resources :categories
    resources :orders, only: %i[index create show new update destroy]
  end

  resources :categories
  resources :products
  resources :carts
  resources :cart_items, only: %i[create update destroy]
  resources :orders, only: %i[index create show new update destroy]
  post 'liqpay_payment_for_email', to: 'liqpay#payment_for_email'
  post 'liqpay_payment_for_callback', to: 'liqpay#payment_callback'
  root "products#index"
end
