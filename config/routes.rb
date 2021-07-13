Rails.application.routes.draw do
  root to: 'sessions#new'
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'home/index'
  get 'home/about'
  resources :groceries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
