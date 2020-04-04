class ChangePostcodeNullConstraintToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :postcode, :string, null: true
  end

  def down
    change_column :users, :postcode, :string, null: false
  end
end
