Rails.application.routes.draw do
  get 'users/new'

  #define root of url
  root 'pages#index'

  get '/home' => 'pages#home'

  get '/profile' => 'pages#profile'

  get '/explore' => 'pages#explore'

  get '/xxx' => 'users#new'

  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
