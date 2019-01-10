Rails.application.routes.draw do
  ## Normal User
  root 'static_pages#index'
  get 'new_request', to: 'static_pages#new_request'
  devise_for :users
  resources :products, only: %i[index show]
  resource :profile, only: %i[show edit update] do
    collection do
      put :upgrade
    end
  end

  ## Admin
  namespace :admin, path: 'users/yoo' do
    root 'static_pages#index'
    resources :products
    resources :users, only: %i[index show] do 
      member do
        put :change_role
      end
    end
  end

  resources :line_bot, only: [] do
    collection do
      post :callback
      get :callback
    end
  end
end
