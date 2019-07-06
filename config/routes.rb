Rails.application.routes.draw do
  root 'main#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  resources :comments do
    collection do
      get 'comment_success'
      get 'comment_error'
    end
  end

  resource :categories do
    collection do
      get 'delete_category'
    end
  end

  get 'print', to: 'print#index'
  get 'reports', to: 'reports#index'
  get 'categories/index', to: 'categories#index'
  post 'reports/filter', to: 'reports#filter'
  post 'categories/add', to: 'categories#add_category'

  put 'enable_reports', to: 'products#updateReports'
  put 'enable_benchmark', to: 'products#updateBenchmark'

  delete 'delete_reports', to: 'products#deleteReports'
  delete 'delete_benchmark', to: 'products#deleteBenchmark'

end
