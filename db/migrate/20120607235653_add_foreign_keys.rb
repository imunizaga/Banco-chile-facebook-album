class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "card_packs", "challenges", :name => "card_packs_challenge_id_fk"
    add_foreign_key "notifications", "users", :name => "notifications_user_id_fk"
    add_foreign_key "user_cards", "cards", :name => "user_cards_card_id_fk"
    add_foreign_key "user_cards", "card_packs", :name => "user_cards_card_pack_id_fk"
    add_foreign_key "user_cards", "users", :name => "user_cards_user_id_fk"
  end
end
