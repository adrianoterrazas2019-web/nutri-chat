Rails.application.routes.draw do
  get "/chat", to: "chat#index"

  devise_for :users

  root "pages#home"

  resources :meals, only: [ :index, :show, :destroy ]

  resource :user_information, path: "profile", only: [ :show, :edit, :update ]
end
