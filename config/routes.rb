Rails.application.routes.draw do
  get 'users/new'

  #define root of url
  root 'users#new'
  
  get '/home' => 'pages#home'

  post '/institutions/new_institute' => 'institutions#new_institute'

  get '/:id/profile' => 'user_profiles#profile'
  get '/:id/about' => 'user_profiles#about'

  get '/:id/friends' => 'friends#show_accepted'
  
  get '/:id/messages' => 'messages#show_message'

  get '/:id/media' => 'user_profiles#media'

  get '/:id/groups' => 'group_pages#current_groups'

  get '/save/online/' => 'users#save_online'
  get '/new/message/' => 'messages#new_message'  


  get '/new' => 'users#new'

  get '/error' => 'pages#error'

  get '/group/' => 'group_pages#get_page'


  get '/signup' => 'users#new'
  get '/login' => 'users#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'


  ##Slam Book
  get '/:id/slams/view' => 'slams#view'
  get '/:id/slams/view_ans' => 'slams#view_ans'
  get '/:id/slams/ans_view' => 'slams#ans_view'
  
  resources :posts
  resources :user_profiles
  resources :blobs
  #User Posts
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
