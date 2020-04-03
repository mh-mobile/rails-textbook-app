class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :address, :string
    change_column :users, :address, :string, null: false
  end

  def down
    remove_column :users, :address, :string
  end
end
