class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :source
      t.integer :set
      t.text :info

      t.timestamps
    end
  end
end
