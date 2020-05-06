# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :delete_all
  belongs_to :user

  default_scope -> { order("created_at DESC") }
end
