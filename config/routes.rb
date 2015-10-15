Rails.application.routes.draw do

  root 'welcome#index'

  get 'welcome/index'
  get 'contact/index'

  resources :reservations
  resources :rooms
  resources :user_sessions
  resources :users

  get 'user' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  
end
