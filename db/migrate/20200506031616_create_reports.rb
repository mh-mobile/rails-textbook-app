# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.date :learning_date
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
