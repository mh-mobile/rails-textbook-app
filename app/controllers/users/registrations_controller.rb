# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # 会員登録用のパラメータの設定
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email,  :password, :password_confirmation])
  end

  # 更新用のパラメメータの設定
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :email, :self_introduction, :password, :password_confirmation, :forward_postcode, :backward_postcode])
  end

  # 更新後のリダイレクト先
  def after_update_path_for(resource)
    user_path(username: resource.username)
  end

  # パスワードなしで更新
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
