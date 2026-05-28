Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resource :user_information, path: "profile", only: [ :show, :edit, :update ]
  resources :meals, only: [ :index, :show, :new, :create, :destroy ] do
    resources :chats, only: [ :create ]
  end
  resources :chats, only: [ :show ] do
    resources :messages, only: [ :create ]
  end
end
