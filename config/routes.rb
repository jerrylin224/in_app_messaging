Rails.application.routes.draw do
  devise_for :users

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end

  resources :messages, only: [:new, :create]

  root to: 'conversations#index'
end
