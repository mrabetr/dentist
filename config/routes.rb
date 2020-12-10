Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :services
  resources :bookings

  resources :users, only: [:index] do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end
end
