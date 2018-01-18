Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end

    collection do
      post :new_move_to_trash
      delete :empty_trash
    end
  end


  get "/admin/conversations/new", to: "admin/conversations#new"
  get "/admin/messages/new", to: "admin/messages#new"
  post "/admin/messages", to: "admin/messages#create"

  resources :users, only: [:index]

  resources :messages, only: [:new, :create]

  root to: 'conversations#index'
end
