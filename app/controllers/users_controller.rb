# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def show
  end

  def index
    @users = User.where.not(id: current_user.id).page(params[:page])
  end

  def following
    @users = @user.following.page(params[:page])
  end

  def followers
    @users = @user.followers.page(params[:page])
  end

  private
    def set_user
      username = params[:username]

      # ユーザー名で検索
      # find_by!でレコードがない場合はActiveRecord::RecordNotFoundをraisesする
      @user = User.find_by!(username: username)
    end
end
