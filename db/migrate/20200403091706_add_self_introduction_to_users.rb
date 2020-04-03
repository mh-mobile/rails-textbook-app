class AddSelfIntroductionToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :self_introduction, :string
    change_column :users, :self_introduction, :string, null: false
  end

  def down
    remove_column :users, :self_introduction, :string
  end
end
