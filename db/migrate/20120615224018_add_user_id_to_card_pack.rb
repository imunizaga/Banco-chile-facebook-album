class AddUserIdToCardPack < ActiveRecord::Migration
  def change
    add_column :card_packs, :user_id, :integer
  end
end
