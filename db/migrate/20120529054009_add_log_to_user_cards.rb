class AddLogToUserCards < ActiveRecord::Migration
  def change
    add_column :user_cards, :log, :text
  end
end
