class AddAlbumToUser < ActiveRecord::Migration
  def change
    add_column :users, :album, :text
    User.reset_column_information
    User.find_each {|u| u.set_album }
  end
end
