# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :followed
      t.belongs_to :follower

      t.timestamps
    end

    add_index :friendships, [:followed_id, :follower_id], unique: true
  end
end
