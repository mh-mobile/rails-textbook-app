# frozen_string_literal: true

class AddUserReferenceToBooks < ActiveRecord::Migration[6.0]
  def up
    add_reference :books, :user, foreign_key: true
    change_column :books, :user_id, :interger, null: false
  end

  def down
    remove_reference :books, :user, foreign_key: true
  end
end
