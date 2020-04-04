# frozen_string_literal: true

class AddPostcodeToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :postcode, :string
    change_column :users, :postcode, :string, null: false
  end

  def down
    remove_column :users, :postcode, :string
  end
end
