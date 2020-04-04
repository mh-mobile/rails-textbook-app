class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  attr_writer :forward_postcode, :backward_postcode 

  validates :postcode, format: { with: /\A\d{3}-\d{4}\Z/ }, if: :postcode_present?

  # usernameのバリデーション
  validates :username, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]{3,8}\Z/ }

  before_validation  :validate_postcode

  def forward_postcode
    @forward_postcode ||= postcode.present? ? postcode.split("-").first : nil
  end

  def backward_postcode
    @backward_postcode ||= postcode.present? ? postcode.split("-").last : nil
  end

  private

  def validate_postcode
    self.postcode = forward_postcode.blank? && backward_postcode.blank? ? nil : "#{forward_postcode}-#{backward_postcode}"
  end

  def postcode_present?
    postcode.present?
  end
end
