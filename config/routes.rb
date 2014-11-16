Rails.application.routes.draw do

  match '/login'      => "user_sessions#create", :as => :login, via: [:get, :post]
  match '/logout'     => 'user_sessions#destroy', via: [:get, :post]
  match '/signup'     => 'user#create', :as => :signup, via: [:get, :post]

  match '/users'      => 'user#list', via: [:get]
  match '/u/:name'    => 'user#show', via: [:get, :post]

  match '/p/:id'      => 'post#list', via: [:post, :get]
  match '/pub'        => 'post#save', via: [:get, :post]
  match '/posts/:id'      => 'post#list_by_user', via: [:get, :post]

  match 'activate(/:activation_code)' => 'user#activate', :as => :activate_account, via: [:get, :post]
  match 'send_activation(/:user_id)' => 'user#send_activation', :as => :send_activation, via: [:get, :post]

  match '/search' => 'search#search', via: [:get, :post]
  match '/search/index' => 'search#searched', via: [:get, :post]

  match '/version' => 'version#number', via: [:get]

  resources :tags
  resources :comments
  resources :likes
  resources :user
  resources :user_sessions
  resources :password_resets, :only => [ :new, :create, :edit, :update ]
  resources :photos, :member => {:crop => :get}

end
