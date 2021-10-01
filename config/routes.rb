Rails.application.routes.draw do
  resources :tasks
  resources :labels, except: :new
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  resources :users#, except: :index
  namespace :admin do
    resources :users#, except: [:create, :new]
  end
  get '*path', to: 'application#not_found'
end
