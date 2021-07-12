Rails.application.routes.draw do
  get 'home/index'
  get 'home/about'
  root to: 'home#index'
  resources :groceries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
