class RenameUserIds < ActiveRecord::Migration
  def up
    rename_column :users, :id_facebook, :facebook_id
    rename_column :users, :id_twitter, :twitter_id
  end
  def down
    rename_column :users, :facebook_id, :id_facebook
    rename_column :users, :twitter_id, :id_twitter
  end
end
