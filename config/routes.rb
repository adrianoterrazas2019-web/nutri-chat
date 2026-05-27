Rails.application.routes.draw do
  get "/chat", to: "chat#index"
  root "pages#home"
  resources :meals, only: [ :index, :show, :destroy ]
end
