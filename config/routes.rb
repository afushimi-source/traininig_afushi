Rails.application.routes.draw do
  resources :tasks
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  scope '/admin' do
    resources :users
  end
end
