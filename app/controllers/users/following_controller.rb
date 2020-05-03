# frozen_string_literal: true

class Users::FollowingController < ApplicationController
  before_action :set_user

  def index
    @users = @user.following.page(params[:page])
  end

  def create
    follow_action(:follow!)
  end

  def destroy
    follow_action(:unfollow!)
  end

  private
    def follow_action(name)
      return head :no_content if current_user == @user
      current_user.send(name, @user) if current_user.can_follow_action?(name, @user)
      render partial: "users/shared/follow", locals: { user: @user }
    end
end
