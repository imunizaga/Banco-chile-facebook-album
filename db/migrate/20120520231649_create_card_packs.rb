class CreateCardPacks < ActiveRecord::Migration
  def change
    create_table :card_packs do |t|
      t.integer :challenge_id

      t.timestamps
    end
  end
end
