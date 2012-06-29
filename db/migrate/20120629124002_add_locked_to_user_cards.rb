class AddLockedToUserCards < ActiveRecord::Migration
  def change
    add_column :user_cards, :locked, :boolean, :default => false
  end
end
