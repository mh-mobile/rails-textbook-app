# frozen_string_literal: true

class Report < ApplicationRecord
  include Commentable
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :learning_date, presence: true, uniqueness: { scope: :user }
  validates :description, presence: true
end
