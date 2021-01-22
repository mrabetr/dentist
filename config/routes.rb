Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :services
  resources :bookings do
    resources :notes, only: :create
    resources :payments, only: :new
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

  resources :patients, only: [:index, :show, :edit, :update]

  resources :medical_forms

  resources :requests, only: [:new, :create, :index, :show]
end
