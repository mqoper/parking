Rails.application.routes.draw do
  resources :users
  resources :spots
  root 'pages#home'
  get 'pages/about'
  get 'pages/history'

  post '/slack/command', to: 'slack/commands#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
