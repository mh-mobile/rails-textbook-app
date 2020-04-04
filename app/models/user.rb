# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, authentication_keys: [:login]

  attr_writer :forward_postcode, :backward_postcode

  # ユーザー名、メールアドレスどちらでもログインできるようにする
  attr_accessor :login

  validates :postcode, format: { with: USERMODEL_POSTCODE_REGEX }, if: :postcode_present?

  # usernameのバリデーション
  validates :username, uniqueness: { case_sensitive: false }, format: { with: USERMODEL_USERNAME_REGEX }, length: { minimum: 3, maximum: 30 }

  before_validation :validate_postcode

  def forward_postcode
    @forward_postcode ||= postcode.present? ? postcode.split("-").first : nil
  end

  def backward_postcode
    @backward_postcode ||= postcode.present? ? postcode.split("-").last : nil
  end

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
    def validate_postcode
      self.postcode = (forward_postcode.blank? && backward_postcode.blank?) ? nil : "#{forward_postcode}-#{backward_postcode}"
    end

    def postcode_present?
      postcode.present?
    end
end
