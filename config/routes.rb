Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
    resources :categories
  end
  resources :categories do
      resources :products
    end
  root "products#index"
end
