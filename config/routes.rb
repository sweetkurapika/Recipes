Rails.application.routes.draw do

  root  'pages#home'

  get     '/home',                to: 'pages#home'

=begin
  get     '/recipes',             to: 'recipes#index'

  get     '/recipes/new',         to: 'recipes#new',      as: 'new_recipe'

  post    '/recipes/',            to: 'recipes#create'

  get     '/recipes/:id/edit',    to: 'recipes#edit',     as: 'edit_recipe'

  patch   '/recipes/:id',         to: 'recipes#update'

  get     '/recipes/:id',         to: 'recipes#show',     as: 'recipe'

  delete  '/recipes/:id',         to: 'recipes#destroy'
=end

  resources :recipes do
    member do
      post 'like'
    end
  end

  resources :chefs, except: :new

  get '/register', to: 'chefs#register'

  get '/login', to: 'auths#login'
  post '/login', to: 'auths#create'
  get '/logout', to: 'auths#logout'

  resources :styles
  resources :ingredients

end
