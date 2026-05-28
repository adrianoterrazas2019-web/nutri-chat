Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  resources :meals, only: [ :index, :show, :new, :create, :destroy ]
  resources :chats, only: [ :show ] do
    resources :messages, only: [ :create ]
  end
end
