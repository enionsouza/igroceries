Rails.application.routes.draw do
  root to: 'home#index'
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'home/index'
  get 'home/about'
  get 'groceries/index/:mode', to: 'groceries#index', as: 'groceries'
  resources :groceries, except: %i[index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
