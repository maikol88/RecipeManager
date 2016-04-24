Rails.application.routes.draw do

  root 'pages#home'

  get '/home', to: 'pages#home'

  resources :recipes do
    member do
      post 'like'
    end
  end
  #this line creates all of below
  #get '/recipes', to: 'recipes#index'
  #get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  #post '/recipes', to: 'recipes#create'
  #this is to handle the submission of form. whenever we create we do post request
  #get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  ##this will render a form because we are doing a submission so we need to use patch because is an edit
  #patch '/recipes/:id', to: 'recipes#update'
  #get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  #delete '/recipes/:id', to: 'recipes#destroy'

  resources :chefs, except: [:new]

  get '/register', to: 'chefs#new'

  get '/login',  to: 'logins#new'
  post'/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'

  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]

end
