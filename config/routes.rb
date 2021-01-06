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

  resources :users, only: [:index, :new] do
    post "create_user", to: "users#create", as: :create, on: :collection
    get :patients, as: :patients, on: :collection
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resources :patients, only: [:show] do
    resources :medical_forms, only: [:new, :create]
  end

  resources :medical_forms, only: [:show, :edit, :update, :destroy]
end
