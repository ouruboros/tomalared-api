Rails.application.routes.draw do
  resources :tasks, except: [:new, :edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # a convenience route
  #resources :sessions, :constraints => { :protocol => "https" }

	#Rutas principales
#  root "post#list"
  #match "/userx", to: 'user_sessions#new', via: [:get, :post]

  #       #Login
  match '/login'      => "user_sessions#create", :as => :login, via: [:get, :post]
  match '/logout'     => 'user_sessions#destroy', via: [:get, :post]
  match '/signup'     => 'users#create', :as => :signup, via: [:get, :post]

  # #Usuario
  # match '/home'         => 'users#edit', via: [:get, :post]
  # match '/edit_me'    => 'users#edit', via: [:get, :post]
  # match '/updatefoto' => 'users#updatefoto', via: [:get, :post]
  # match '/updatedatos'=> 'users#updatedatos', via: [:get, :post]
  # match '/updateImage'=> 'users#updateImage', via: [:get, :post]
  # match '/update' => 'users#update', via: [:get, :post]
  # match '/delete_user' => 'users#delete_user', via: [:get, :post]
  # match '/crop' => 'users#crop', via: [:get, :post]

  #       #Grupos
  # #Listados
  #       #Funciones
  #       match '/follow/:id' => 'tag#follow_tag', via: [:get, :post]
  #       match '/unfollow/:id' => 'tag#unfollow_tag', via: [:get, :post]

  # #Tumblr
  # #Listados por post
  # match '/post/:pagina/:id'   => 'post#list', via: [:get, :post]
  # match '/post/:pagina'     => 'post#list', via: [:get, :post]
  # match '/network/note/:note_type'   => 'post#note', via: [:get, :post]

  # #Funciones
  # match '/save'  => 'post#save', via: [:get, :post]
  # match '/delete'     => 'post#delete', via: [:get, :post]
  # match '/delete_tag' => 'post#delete_tag', via: [:get, :post]
  # match '/post/save' => 'post#save', via: [:get, :post]
  
  #       		#Listados por usuario
  #       		#comentarios
  # match '/comment/new' => 'comment#new', via: [:get, :post]
  # match '/comment/delete/:id' => 'comment#delete', via: [:get, :post]
  # match '/comment/list/:id' => 'comment#list', via: [:get, :post]

  #       #Likes
  # match '/vote' => 'vote#vote', via: [:get, :post]

  match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account, via: [:get, :post]
  match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation, via: [:get, :post]

  #       #Share
  # match '/share/:post_id' => 'share#share', via: [:get, :post]
  # match '/unshare/:post_id' => 'share#unshare', via: [:get, :post]

  # #Interaction
  # match '/interaction/share/:post_id' => 'interaction#share', via: [:get, :post]
  
  # match '/notifications' => 'notification#list', via: [:get, :post]
  # match '/notif/index/:note_type' => 'notification#index', via: [:get, :post]
  # match '/notif/list' => 'notification#list', via: [:get, :post]
  # match '/notif/read/:note_type' => 'notification#read', via: [:get, :post]

  #       #Buscador
  match '/search' => 'search#search', via: [:get, :post]
  match '/search/index' => 'search#searched', via: [:get, :post]
  

  #       #Futuras ampliaciones
  # match 'chat'       => 'chat#index', via: [:get, :post]
  # match 'maps'       => 'maps#index', via: [:get, :post]

  # match 'password_resets'=> 'password_resets#new', via: [:get, :post]
  # match 'password_resets/edit'=> 'password_resets#edit', via: [:get, :post]
  # match 'password_resets/create'=> 'password_resets#create', via: [:get, :post]
  
  # match '/users/crop/' => 'users#crop', via: [:get, :post]
  
  # match '/desde' => 'application#calcular_fecha', via: [:get, :post]
  
  #resources
  resources :tags
  resources :comments
  resources :likes
  resources :users                  # give us our some normal resource routes for users
  resource :user, :as => 'account'
  resources :user_sessions
  resource :password_resets, :only => [ :new, :create, :edit, :update ]
  resources :photos, :member => {:crop => :get}
end
