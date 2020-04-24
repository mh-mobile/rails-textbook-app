class Users::FollowController < ApplicationController
  before_action :set_user, :set_redirect_path

  # フォローのリクエスト種別
  # ユーザリストからのリクエストはusers
  # プロフィールからのリクエストはprofile
  module RequestType
    USERS = "users".freeze
    PROFILE = "profile".freeze
  end
  RequestType.freeze

  def follow
    return redirect_to @redirect_path if current_user == @user
    current_user.follow!(@user) unless current_user.following?(@user)
    redirect_to @redirect_path, notice: "フォローしました"
  end

  def unfollow
    return redirect_to @redirect_path if current_user == @user
    current_user.unfollow!(@user) if current_user.following?(@user)
    redirect_to @redirect_path, notice: "フォローを解除しました"
  end

  private

  def set_user
    username = params[:username]

    @user = User.find_by!(username: username)
  end

  def set_redirect_path
    request_type = follow_params[:request_type]

    case request_type
    when RequestType::PROFILE 
      @redirect_path = user_path(username: @user.username)
    when RequestType::USERS
      @redirect_path = user_index_path
    end
  end

  def follow_params
    params.require(:follow).permit(:request_type)
  end

end
