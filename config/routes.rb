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
  get 'benchmarks', to: 'benchmarks#index'
  post 'reports/filter', to: 'reports#filter'
  post 'benchmarks/compare', to: 'benchmarks#compare'

end
