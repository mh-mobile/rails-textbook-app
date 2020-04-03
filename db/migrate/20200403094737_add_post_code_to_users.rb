class AddPostCodeToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :post_code, :string
    change_column :users, :post_code, :string, null: false
  end

  def down
    remove_column :users, :post_code, :string
  end
end
