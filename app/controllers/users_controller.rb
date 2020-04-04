# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  private
    def set_user
      username = params[:username]

      # ユーザー名で検索
      # find_by!でレコードがない場合はActiveRecord::RecordNotFoundをraisesする
      @user = User.find_by!(username: username)
    end
end
