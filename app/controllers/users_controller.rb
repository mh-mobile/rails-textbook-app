# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def show
  end

  def index
    @users = User.where.not(id: current_user.id)
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  private
    def set_user
      username = params[:username]

      # ユーザー名で検索
      # find_by!でレコードがない場合はActiveRecord::RecordNotFoundをraisesする
      @user = User.find_by!(username: username)
    end
end
