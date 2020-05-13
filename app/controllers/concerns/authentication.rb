# frozen_string_literal: true

module Authentication
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
end
