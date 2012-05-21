class AddIdsToUserCard < ActiveRecord::Migration
  def change
    add_column :user_cards, :user_id, :integer
    add_column :user_cards, :card_id, :integer
  end
end
