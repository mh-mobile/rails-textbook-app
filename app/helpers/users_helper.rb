# frozen_string_literal: true

module UsersHelper
  # ログインユーザーのページかどうか
  def current_user_page?
    @user.username == current_user.username
  end
end
