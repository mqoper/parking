Rails.application.routes.draw do
  resources :spots
  root 'pages#home'
  get 'pages/about'
  get 'pages/history'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  post '/slack/command', to: 'slack/commands#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
