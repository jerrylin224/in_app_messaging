Rails.application.routes.draw do
  devise_for :users

  resources :conversations, only: [:index, :show, :destroy]

  root to: 'conversations#index'
end
