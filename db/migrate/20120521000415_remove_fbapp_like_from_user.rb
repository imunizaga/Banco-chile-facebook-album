class RemoveFbappLikeFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :fbapp_like
      end

  def down
    add_column :users, :fbapp_like, :integer
  end
end
