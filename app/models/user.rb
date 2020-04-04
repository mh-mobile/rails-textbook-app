# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, authentication_keys: [:login]

  # 郵便番号XXX-YYYYに対して以下の値を格納
  # XXXをforward_postcodeに設定
  # YYYをbackward_postcodeに設定
  attr_writer :forward_postcode, :backward_postcode

  # ユーザー名、メールアドレスどちらでもログインできるようにする
  attr_accessor :login

  # 郵便番号のバリデーション
  # 入力値がある場合のみバリデーションを行う
  validates :postcode, format: { with: USERMODEL_POSTCODE_REGEX }, if: :postcode_present?

  # ユーザー名のバリデーション
  validates :username, uniqueness: { case_sensitive: false }, format: { with: USERMODEL_USERNAME_REGEX }, length: { minimum: 3, maximum: 30 }

  # バリデーション前に郵便番号を設定
  before_validation :set_postcode

  # 郵便番号の前方部分の値
  def forward_postcode
    @forward_postcode ||= postcode.present? ? postcode.split("-").first : nil
  end

  # 郵便番号の後方部分の値
  def backward_postcode
    @backward_postcode ||= postcode.present? ? postcode.split("-").last : nil
  end

  # ユーザー名かメールアドレスでユーザーを検索する。
  # ref. https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { value: login }]).first
    else
      where(conditions).first
    end
  end

  private
    # 郵便番号を設定
    def set_postcode
      # フォームデータから郵便番号を組み立てる
      self.postcode = (forward_postcode.blank? && backward_postcode.blank?) ? nil : "#{forward_postcode}-#{backward_postcode}"
    end

    # 郵便番号が設定されているか
    def postcode_present?
      postcode.present?
    end
end
