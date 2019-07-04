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

  get 'print', to: 'print#index'
  #get ':shop_name' , to: 'comments#new_whit_shop_name'
  get 'reports', to: 'reports#index'

  put 'enable_reports', to: 'enable_reports#updateReports'
  put 'enable_benchmark', to: 'enable_reports#updateBenchmark'
end
