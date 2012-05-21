class AddFbAppLikeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fbapp_like, :string
  end
end
