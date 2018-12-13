Rails.application.routes.draw do
  ## Normal User
  root 'static_pages#index'
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
end
