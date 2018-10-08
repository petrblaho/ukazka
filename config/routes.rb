Rails.application.routes.draw do
  resources :users
  resources :messages
  resources :channels do
    resources :messages
  end
  get 'pages/main'
  get 'foo' => 'pages#main'
  get 'pages/secret' => 'pages#secret'
  get 'pages/about'
  root 'pages#main'
  get 'signup' => 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # log in page with form:
	get '/login'     => 'sessions#new'
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	# delete action to log out:
	get '/logout' => 'sessions#destroy'  
	delete '/logout' => 'sessions#destroy'  
end
