# frozen_string_literal: true

class Report < ApplicationRecord
  include Commentable
  belongs_to :user

  default_scope -> { order("created_at DESC") }
end
