# frozen_string_literal: true

class Users::FollowingController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = @user.following.page(params[:page])
  end
end
