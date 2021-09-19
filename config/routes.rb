Rails.application.routes.draw do
  resources :tasks
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  namespace :admin do
    resources :users, only: [:index, :show,  :edit, :destroy]
  end
end
