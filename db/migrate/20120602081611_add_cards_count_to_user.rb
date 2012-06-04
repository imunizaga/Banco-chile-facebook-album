class AddCardsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :cards_count, :integer, :default => 0
    User.reset_column_information
    User.all.each {|u| u.update_attribute  :cards_count, u.cards.length}
  end
end
