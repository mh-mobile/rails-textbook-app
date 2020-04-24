# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  # current_userでデコレータを使えるようする。
  # ref. https://github.com/amatsuda/active_decorator/issues/98
  def current_user
    (user = super) && ActiveDecorator::Decorator.instance.decorate(user)
  end

  rescue_from SecurityError do |exception|
    redirect_to authenticated_root_path, alert: "アクセス権限がありません"
  end
  
end
