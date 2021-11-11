Rails.application.routes.draw do
  resources :spots
  root 'pages#home'
  get 'pages/about'
  get 'pages/history'
  get 'signup', to: 'users#new'
  post 'book', to: 'spots#book'
  post 'free', to: 'spots#free'


  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post '/slack/command', to: 'slack/commands#create'
  post '/slack/register', to: 'slack/commands#register'

  post '/auth/slack/callback', to: 'omniauth_callbacks#slack'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
