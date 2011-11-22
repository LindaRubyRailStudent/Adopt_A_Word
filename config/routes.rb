Aaw::Application.routes.draw do

  resources :posts
  match '/auth/:provider/callback' => 'authentications#create'
  resources :authentications

  get "authentications/index"
  get "authentications/create"
  get "authentications/destroy"

  resources :searches
  get "pages/home"
  get "pages/about"
  match "/words/search" => "words#search"

  resources :words do
    member do
      get 'search'
    end
  end
  resources :adoptions
  resources :pages

  match '/home', :to => 'pages#home'
  match '/about',:to => 'pages#about'
  match '/user' => "users#show", :as => :user_root
  match '/usershow', :to => 'users#show'

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users, :only => [:index, :show]

  # :controllers => {:sessions => 'custom_devise/sessions'}, :skip => [:sessions] do
   # get 'signin' => 'custom_devise/sessions#new', :as => :new_user_session
   # post 'signin' => 'custom_devise/sessions#create', :as => :user_session
   # get 'signout' => 'custom_devise/sessions#destroy', :as => :destroy_user_session
 # end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
