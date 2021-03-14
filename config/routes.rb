Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  # this was added after removing :registerable from User model to limit external sign ups
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'pages#home'
  get 'links', to: 'pages#links'

  resources :services
  resources :bookings do
    resources :notes, only: :create
    resources :payments, only: :new
    patch :update_amount, on: :member
  end

  resources :notes, only: [:edit, :update, :destroy]

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  resources :users, only: [:index, :new, :edit] do
    post "create_user", to: "users#create", as: :create, on: :collection
    patch "update_user", to: "users#update", as: :update, on: :member
    get :patients, as: :patients, on: :collection
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resources :patients, only: [:index, :show, :edit, :update, :destroy]

  resources :medical_forms

  resources :requests, only: [:new, :create, :index, :show]

  resources :treatments, except: :index
end
