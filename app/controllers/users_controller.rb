class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  private 

  def set_user
    username = params[:username]
    @user = User.find_by(username: username)
  end
end
