# frozen_string_literal: true

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
      current_user.send(name, @user) if current_user.canFollowAction?(name, @user)
      render partial: "users/shared/follow", locals: { user: @user }
    end
end
