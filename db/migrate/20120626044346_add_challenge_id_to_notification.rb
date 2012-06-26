class AddChallengeIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :challenge_id, :integer
  end
end
