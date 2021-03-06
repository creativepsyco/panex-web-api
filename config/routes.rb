PanexWebApi::Application.routes.draw do

  get "/jobs" => "jobs#index"
  get "/jobs/test_service_run" => "jobs#test_service_run"
  post "/jobs/service_run" => "jobs#run_service"

  match "/delayed_job" => DelayedJobWeb, :anchor => false

  post "/patients/:patient_id/patient_data/upload" => "patient_data#upload"
  get "/patients/:patient_id/patient_data/" => "patient_data#index"
  get "/patients/patient_data/" => "patient_data#index_all"
  get "/patients/:patient_id/patient_data/download/:file_id" => "patient_data#download"

  resources :patients
  resources :apps, :only => [:index, :show]
  resources :services, :only => [:index, :show]


  devise_for(:users, :controllers => { :sessions => "sessions" })
  
  resources :users do
    resources :apps
    resources :services #, :only => [:create, :update, :destroy]
  end

  root :to => "home#index"
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
