# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = @user.followers.page(params[:page])
  end
end
