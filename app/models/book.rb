# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :delete_all

  default_scope -> { order("created_at DESC") }

  def self.following_feeds(user)
    following_ids_sql = "SELECT followed_id from friendships WHERE follower_id = :user_id"
    where("user_id IN (#{following_ids_sql}) OR user_id = :user_id", user_id: user.id)
  end
end
