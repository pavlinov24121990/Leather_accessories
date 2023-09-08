Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}
  namespace :admin do
    resources :products
    resources :categories
  end
  resources :categories
  resources :products
  resources :carts do
    post 'add_to_cart/:product_id', to: 'carts#add_to_cart', as: :add_to_cart
    delete 'remove_from_cart/:product_id', to: 'carts#remove_from_cart', as: :remove_from_cart
  end
  root "products#index"
end
