Rails.application.routes.draw do
  root 'comments#index'

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
  get ':shop_name' , to: 'comments#new_whit_shop_name'
end
