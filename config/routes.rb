Rails.application.routes.draw do

  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications, :token_info
  end

  root 'main#index'
  get 'api/v1/userapp/test' => 'api/v1/main#test_action', as: :user_app_test
  post 'api/v1/userapp/create' => 'api/v1/main#userapp', as: :user_app_create
  post 'api/v1/search' => 'api/v1/main#search_caret_properties', as: :search_caret_properties
  post 'api/v1/like' => 'api/v1/main#like_property', as: :like_property
  post 'api/v1/clear' => 'api/v1/main#clear_user_like', as: :clear_user_like
  post 'api/v1/getLikes' => 'api/v1/main#user_liked_properties', as: :user_liked_properties
  post 'api/v1/getPhotos' => 'api/v1/main#search_caret_photos', as: :search_caret_photos
  post 'api/v1/getPolygon' => 'api/v1/main#get_polygon', as: :get_polygon

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

end
