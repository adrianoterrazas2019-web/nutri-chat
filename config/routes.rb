Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  resources :meals, only: [ :index, :show, :destroy ]
end
