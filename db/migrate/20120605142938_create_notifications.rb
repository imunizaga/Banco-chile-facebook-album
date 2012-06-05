class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :description
      t.string :details
      t.integer :n_cards

      t.timestamps
    end
  end
end
