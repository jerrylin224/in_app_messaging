Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  devise_for :users, controllers: { registrations: "registrations" }

  resources :galleries

  resources :things

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
      put :toggle_pinned
    end

    collection do
      put :new_move_to_trash
      delete :empty_trash
      put :change_trash_message_state
      delete :change_trash_message_state
    end
  end


  # get "/admin/conversations/new", to: "admin/conversations#new"
  get "/admin/messages/new", to: "admin/messages#new"
  post "/admin/messages", to: "admin/messages#create"

  resources :users, only: [:index]

  resources :messages, only: [:new, :create]

  root to: 'conversations#index'
end
