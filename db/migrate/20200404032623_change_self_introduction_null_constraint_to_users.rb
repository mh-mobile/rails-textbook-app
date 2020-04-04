class ChangeSelfIntroductionNullConstraintToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :self_introduction, :string, null: true
  end

  def end
    change_column :users, :self_introduction, :string, null: false
  end
end
