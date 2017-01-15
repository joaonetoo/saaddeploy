Rails.application.routes.draw do
  resources :line_cases
  resources :references
  resources :questions do
    collection do
      post 'add'
    end
  end
  resources :study_cases do
    collection do
      get 'search'
      get 'list'
      get 'autocomplete_study_case_title'
    end
  end
  resources :strategies
  resources :objectives
  resources :threats_answers
  resources :threats
  resources :weakness_answers
  resources :weaknesses
  resources :opportunity_answers
  resources :opportunities
  resources :strength_answers
  resources :strengths
  resources :matriculations
  resources :answer_notes
  resources :answers
  resources :resposta
  resources :atividade_extras
  get 'principals_area/index'

  get 'principals_area/aprove'

  get 'principals_area/create_video'

  get 'principals_area/list'

  post 'principals_area/list'

  get 'principals_area/my_events'

  get 'principals_area/search_anchors'

  get 'principals_area/search_plans'

  get 'principals_area/send_video'

  get 'principals_area/show_plan'

  get 'principals_area/videos_index'


  resources :projects do
      collection do
        post 'observation'
      end
  end
  resources :activities
  resources :events do
    collection do
        get 'public_events'
        get 'public_show'
        get 'pdf_event'
        get 'certificate_event'
        post 'certificate_event'
        get 'certificate_project'
        post 'certificate_project'
        get 'approve_project'
    end
  end
  get 'coordinators_area/index'

  post 'coordinators_area/create_video'

  get 'coordinators_area/aprove'

  post 'coordinators_area/list'

  get 'coordinators_area/search_plans'

  get 'coordinators_area/send_video'

  get 'coordinators_area/show_plan'

  get 'coordinators_area/videos_index'

  get 'coordinators_area/my_events'

  get 'coordinators_area/finished_events'

  get 'coordinators_area/show_finished_event'

  get 'coordinators_area/search_anchors'

  get 'coordinators_area/search_learning'

  get 'coordinators_area/search_analytics'

  get 'coordinators_area/search_learning_analytics'

  resources :videos
  resources :learning_quizzes
  resources :learning_styles
  resources :learning_results do
    collection do
      post 'new'
      get 'search'
      post 'list'
      post 'show_by_date'
      get 'analytics'
      post 'analytic_list'
      post 'compare_by_date'
      get 'pdf_list'
      get 'subject_selection'
      get 'subject2_selection'
      get 'classroom_selection'
      get 'classroom2_selection'
      get 'course_selection'
      get 'course2_selection'
      get 'center_selection'
      get 'center2_selection'
      get 'campu_selection'
      get 'campu2_selection'
    end
  end
  get 'teachers_area/index'
  get 'teachers_area/search_plans'
  post 'teachers_area/list'
  post 'teachers_area/show_plan'
  get 'teachers_area/show_plan'
  get 'teachers_area/pdf_plan'
  get 'teachers_area/add_note'
  get 'teachers_area/send_video'
  post 'teachers_area/create_video'
  get 'teachers_area/videos_index'
  get 'teachers_area/send_atividade_extra'
  post 'teachers_area/create_atividade_extra'
  get 'teachers_area/list_atividades'
  get 'teachers_area/aprove_answer'
  get 'teachers_area/search_learning'
  get 'teachers_area/search_analytics'

  get 'student_area/index'
  get 'student_area/pdf_plan'
  get 'student_area/my_learning_result'
  post 'student_area/my_learning_result'
  get 'student_area/my_result'
  post 'student_area/my_result'
  get 'student_area/videos_index'
  get 'student_area/unsubscribe_video'
  get 'student_area/list_atividades'
  get 'student_area/list_answers'
  get 'student_area/compare_anchors'
  post 'student_area/compare_anchors'
  get 'student_area/compare_learning'
  post 'student_area/compare_learning'
  get 'student_area/my_plan'
  post 'student_area/my_plan'
  get 'student_area/classrooms'
  get 'student_area/classroom_show'
  post 'student_area/classroom_show'




  resources :planos
  resources :anchorinfos
  resources :notes
  resources :anchors
  resources :results do
    collection do
      get 'search'
      post 'list'
      post 'show_by_date'
      get 'analytics'
      post 'analytic_list'
      post 'compare_by_date'
      get 'subject_selection'
      get 'subject2_selection'
      get 'ano_selection'
      get 'semestre_selection'
      get 'classroom_selection'
      get 'classroom2_selection'
      get 'course_selection'
      get 'course2_selection'
      get 'center_selection'
      get 'center2_selection'
      get 'campu_selection'
      get 'campu2_selection'
    end
  end
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
  post 'quiz/index'
  post 'quiz/answer'

  get 'admin/search'
  get 'admin/index'
  get 'admin/aprove'

  resources :classrooms do
    collection do
      get 'add_user'
      get 'autocomplete_user_nome'
      get 'remove_user'
      get 'search'
      get 'list'
      post 'list'
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
      get 'autocomplete_subject_nome'
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
