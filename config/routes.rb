Rails.application.routes.draw do
  get 'users/new'

  #define root of url
  root 'users#new'
  
  get '/home' => 'pages#home'

  get '/:id/profile' => 'user_profiles#profile'
  get '/:id/about' => 'user_profiles#about'

  get '/:id/friends' => 'user_profiles#friends'

  get '/:id/media' => 'user_profiles#media'
  

  get '/new' => 'users#new'

  get '/error' => 'pages#error'


  get '/signup' => 'users#new'
  get '/login' => 'users#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :posts
  resources :user_profiles
  #User Posts
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
