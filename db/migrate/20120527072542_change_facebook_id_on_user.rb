class ChangeFacebookIdOnUser < ActiveRecord::Migration
  def change
    change_column :users, :facebook_id, :bigint
  end
end
