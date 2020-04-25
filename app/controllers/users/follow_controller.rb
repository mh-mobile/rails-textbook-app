class Users::FollowController < ApplicationController
  before_action :set_user

  def follow
    follow_action(:follow!)
  end

  def unfollow
    follow_action(:unfollow!)
  end

  private

  def follow_action(name)
    return head :no_content if current_user == @user

    if canFollow?(name) || canUnfollow?(name)
      current_user.send(name, @user)
    end

    render partial: "users/shared/follow", locals: { user: @user }
  end

  def canFollow?(name)
    name == :follow! && !current_user.following?(@user)
  end

  def canUnfollow?(name)
    name == :unfollow! && current_user.following?(@user)
  end
 

  def set_user
    username = params[:username]

    @user = User.find_by!(username: username)
  end

end
