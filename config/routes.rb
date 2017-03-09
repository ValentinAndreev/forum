Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'
  resources :usersessions, except: [:new, :destroy]
  resources :users
  get 'login' => 'usersessions#new', as: :login
  post 'logout' => 'usersessions#destroy', as: :logout  
end
