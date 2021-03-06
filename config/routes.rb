Rails.application.routes.draw do
  resource :sign_up, only: [:create]
  resource :sign_in, only: [:create]
  resources :users, only: [:update, :destroy, :index, :show]
  resources :posts, only: [:create, :update, :index ,:destroy]
end