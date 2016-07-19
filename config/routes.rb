Rails.application.routes.draw do
  get 'users/create'

  root 'home#index'

  get '/register', to: 'users#new'
  post '/logout', to: 'users#logout'
  post '/login', to: 'users#login'
  post '/create', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
