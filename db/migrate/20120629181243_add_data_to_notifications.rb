class AddDataToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :data, :string, :default => ""
  end
end
