class ChangeAddressNullConstraintToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :address, :string, null: true
  end

  def down
    change_column :users, :address, :string, null: false
  end

end
