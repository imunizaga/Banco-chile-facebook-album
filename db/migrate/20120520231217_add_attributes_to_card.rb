class AddAttributesToCard < ActiveRecord::Migration
  def change
    add_column :cards, :log, :text
  end
end
