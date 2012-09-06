class UpdateUserAlbums < ActiveRecord::Migration
  def up
    begin
      users = User.all
      users.each do |user|
        user.set_album
      end
    rescue Exception
    end
  end

  def down
  end
end
