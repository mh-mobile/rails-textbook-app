# frozen_string_literal: true

class Report < ApplicationRecord
  include Commentable
  belongs_to :user

  default_scope -> { order("created_at DESC") }

  validates :title, presence: true
  validates :learning_date, presence: true, uniqueness: { scope: :user, message: "指定の日付の日報を既に作成済みです" }
  validates :description, presence: true
end
