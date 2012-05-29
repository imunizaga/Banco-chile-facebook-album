class RemoveLogFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :log
      end

  def down
    add_column :cards, :log, :text
  end
end
