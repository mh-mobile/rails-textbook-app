class Users::FollowController < ApplicationController
  before_action :set_user

  def follow
    return head :no_content if current_user == @user
    current_user.follow!(@user) unless current_user.following?(@user)
  end

  def unfollow
    return head :no_content if current_user == @user
    current_user.unfollow!(@user) if current_user.following?(@user)
  end

  private

  def set_user
    username = params[:username]

    @user = User.find_by!(username: username)
  end

end
