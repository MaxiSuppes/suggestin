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
  get 'reports', to: 'reports#index'
  get 'categories/index', to: 'categories#index'
  post 'reports/filter', to: 'reports#filter'
end
