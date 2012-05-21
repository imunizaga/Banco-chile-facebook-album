class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :n_cards
      t.integer :type
      t.text :description

      t.timestamps
    end
  end
end
