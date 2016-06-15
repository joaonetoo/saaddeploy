Rails.application.routes.draw do
  resources :anchorinfos
  resources :anchors
  resources :results
  resources :quizzes
  resources :centers do
    collection do
      get 'autocomplete_center_name'
    end
  end

  resources :campus do
    collection do
      get 'autocomplete_campu_name'
    end
  end

  get 'quiz/index'
  post 'quiz/answer'

  get 'admin/search'
  get 'admin/index'
  get 'admin/aprove'

  resources :classrooms do
    collection do
      get 'add_user'
      get 'autocomplete_user_nome'
    end
  end
  resources :administrators
  resources :principals
  resources :coordinators
  resources :teachers
  resources :students do
    collection do
    get 'autocomplete_course_nome'
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :subjects do
    collection do
      get 'search'
    end
  end

  resources :courses do
    collection do
      get 'search'
      get 'autocomplete_course_nome'
    end
  end


  resources :institutions do
    collection do
      get 'search'
      get 'autocomplete_institution_nome'
    end
  end



  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'
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
