Rails.application.routes.draw do
  root "pages#home"
  resources :meals, only: [ :index, :show ]
end
