class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  attr_accessor :forward_postcode, :backward_postcode 

  validates :forward_postcode, presence: true
  validates :backward_postcode, presence: true
  validates :postcode, format: { with: /\A\d{3}-\d{4}\Z/ }

  before_validation  :validate_postcode

  private

  def validate_postcode
    self.postcode = "#{forward_postcode}-#{backward_postcode}"
  end
end
