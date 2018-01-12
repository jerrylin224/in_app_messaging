Rails.application.routes.draw do
  devise_for :users

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
    end

    collection do
      delete :empty_trash
    end
  end

  resources :messages, only: [:new, :create]

  root to: 'conversations#index'
end
