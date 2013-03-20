Client::Application.routes.draw do
  get "login/index"

  resources :promos


  resources :schools

  match "votes/forArticle" => "votes#voteForArticle", :via => :post
  match "votes/unvoteforArticle" => "votes#unvoteForArticle", :via => :post

  match "votes/forAcomment" => "votes#voteForAcomment", :via => :post
  match "votes/unvoteforAcomment" => "votes#unvoteForAcomment", :via => :post
  resources :votes


  resources :scores


  resources :gossips


  resources :authors


  resources :tags


  resources :events

  match "articles/list" => "articles#list"
  match "articles/filterbylogin/:login" => "articles#filterbylogin"
  resources :articles do
    resources :acomments
  end
 

  
  resources :jobs


  resources :groups


  resources :users

  match "login/signout" => "login#signout"

  resources :login


  get "home/index"




  resources :home

  root :to => "login#index"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
