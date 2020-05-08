# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :delete_all
  end

  def plural_name
    self.class.to_s.downcase.pluralize
  end
end
