Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions

  delete '/logout' => 'sessions#destroy', as: :logout

  resources :categories, only: [:show]
  resources :products, only: [:show] do
    get :search, on: :collection
  end
  
  resources :shopping_carts
  resources :addresses do
    member do
      put :set_default_address
    end
  end
  resources :orders
  resources :payments, only: [:index]

  namespace :dashboard do
    scope 'profile' do
      controller :profile do
        get :password
        put :update_password
      end
    end

    resources :orders, only: [:index]
    resources :addresses, only: [:index]
  end

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
  end
end
