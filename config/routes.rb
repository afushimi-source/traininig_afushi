Rails.application.routes.draw do
  resources :tasks
  resources :labels, only: [:index, :edit, :create, :update, :destroy]
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end
end
