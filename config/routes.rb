Rails.application.routes.draw do
  get 'pages/home'

  get '/home', to: 'pages#home'

  root 'pages#home'
end
