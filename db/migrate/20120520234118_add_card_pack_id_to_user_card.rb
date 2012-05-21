class AddCardPackIdToUserCard < ActiveRecord::Migration
  def change
    add_column :user_cards, :card_pack_id, :integer
  end
end
