class ModifyFieldsOnNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :n_cards

    change_column :notifications, :title, :text, :limit => nil
    change_column :notifications, :description, :text, :limit => nil
    change_column :notifications, :details, :text, :limit => nil

    add_column :notifications, :user_id, :integer
    add_column :notifications, :receiver_id, :integer
    add_column :notifications, :sender_id, :integer
    add_column :notifications, :cards_in, :text, :limit => nil
    add_column :notifications, :cards_out, :text, :limit => nil
    add_column :notifications, :status, :integer
    add_column :notifications, :renewal, :date
  end
end
