# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  before_action :authenticate_user!

  private
    def set_user
      username = params[:username]

      # ユーザー名で検索
      # find_by!でレコードがない場合はActiveRecord::RecordNotFoundをraisesする
      @user = User.find_by!(username: params[:username])
    end

    # current_userでデコレータを使えるようする。
    # ref. https://github.com/amatsuda/active_decorator/issues/98
    def current_user
      (user = super) && ActiveDecorator::Decorator.instance.decorate(user)
    end
end
