Rails.application.routes.draw do
  get "/chat", to: "chat#index"
  devise_for :users
  root "pages#home"
  resources :meals, only: [ :index, :show, :destroy ]
  get "profile", to: "pages#profile"
  resource :user_information, only: [ :edit, :update ]
end
