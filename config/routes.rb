Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :categorys do
      resources :products
    end
  end
  resources :categorys do
      resources :products
    end
  root "products#index"
end
