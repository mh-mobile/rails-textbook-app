# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :commentable, polymorphic: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
