class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :friends, :text
    add_column :users, :foursquare_id, :integer
    add_column :users, :referals, :text
  end
end
