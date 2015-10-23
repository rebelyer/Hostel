Rails.application.routes.draw do

  get 'language/:ln' => 'languages#change', as: :language

  root 'welcome#index'

  get 'welcome/index'
  get 'contact' => 'contact#index', as: :contact

  resources :reservations, only: [:new, :create]
  resources :rooms, only: [:index, :show]
  resources :user_sessions
  resources :users

  namespace :admin do
   resources :reservations, except: [:new, :create]
   resources :rooms, except: [:index, :show]
  end

  get 'user' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  
end
