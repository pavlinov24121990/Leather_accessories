Rails.application.routes.draw do
  resources :category do
    resources :product
  end
  root "products#index"
end
