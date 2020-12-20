Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :services
  resources :bookings

  resources :users, only: [:index, :new] do
    post "create_user", to: "users#create", as: :create, on: :collection
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end
end
