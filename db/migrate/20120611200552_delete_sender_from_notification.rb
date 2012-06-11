class DeleteSenderFromNotification < ActiveRecord::Migration
  def change
      remove_column :notifications, :sender_id
  end
end
