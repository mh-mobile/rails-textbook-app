# frozen_string_literal: true

module Authentication
  def check_permission(user)
    redirect_to authenticated_root_path, alert: "アクセス権限がありません" unless current_user == user
  end

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
end
