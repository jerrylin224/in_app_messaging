class UsersController < ApplicationController
  def index
    @users = User.order('created_at DESC').page(params[:page])
  end

  def update_form
    byebug
  end
end
