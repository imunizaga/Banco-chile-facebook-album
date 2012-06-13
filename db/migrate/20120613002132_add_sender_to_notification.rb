class AddSenderToNotification < ActiveRecord::Migration
  def change
      remove_column :notifications, :receiver_id
      add_column :notifications, :sender_id, :integer
  end
end
