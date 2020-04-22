class Users::FollowController < ApplicationController
  before_action :set_user

  def follow
    return redirect_to user_path(username: @user.username) if current_user == @user
    current_user.follow!(@user) unless current_user.following?(@user)
    redirect_to user_path(username: @user.username), notice: "フォローしました"
  end

  def unfollow
    redirect_to user_path(username: @user.username), notice: "フォローを解除しました"
  end

  private

  def set_user
    username = params[:username]

    @user = User.find_by!(username: username)
  end

end
