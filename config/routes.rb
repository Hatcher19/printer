Por::Application.routes.draw do
  root :to => "pages#home"
  devise_for :users, :controllers => { :registrations => "registrations" }                                         
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
    end
  resources :users do
    resource :braintree_customer do
      resources :credit_cards do
        resources :subscriptions
      end
      resources :braintree_addresses
    end
  end
  resources :subscriptions, except: [:new, :create]
  resources :orders, only: [:index, :show, :update, :create, :new]
  resources :accounts, only: [:index, :show, :update, :create, :new]
  resources :customers, only: [:index, :show, :update, :create, :new]
  resources :products, only: [:show, :update, :create, :new]
  resources :addresses, only: [:show, :update, :create, :new]
  resources :artworks, only: [:show, :update, :create, :new]
  resources :orders do
    resources :users
  end
  resources :customers do
    resources :addresses
  end
  resources :accounts do
    resources :users
    resources :orders
    resources :customers
  end
  resources :orders do
    collection { post :search, to: 'orders#index' }
  end
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
