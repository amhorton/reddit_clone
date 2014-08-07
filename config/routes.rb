Rails.application.routes.draw do
  resource :session, except: [:edit, :update, :show]
  resources :users

  resources :subs
  resources :posts do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]

  post '/comments/:comment_id/downvote' => 'votes#comment_downvote',
    as: 'comment_downvote'

  post '/comments/:comment_id/upvote' => 'votes#comment_upvote',
    as: 'comment_upvote'

  post '/posts/:post_id/downvote' => 'votes#post_downvote',
    as: 'post_downvote'

  post '/posts/:post_id/upvote' => 'votes#post_upvote',
    as: 'post_upvote'

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
