class ModifyFieldsOnNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :n_cards

    change_column :notifications, :title, :text
    change_column :notifications, :description, :text
    change_column :notifications, :details, :text

    add_column :notifications, :user_id, :integer
    add_column :notifications, :receiver_id, :integer
    add_column :notifications, :sender_id, :integer
    add_column :notifications, :cards_in, :text
    add_column :notifications, :cards_out, :text
    add_column :notifications, :status, :integer
    add_column :notifications, :renewal, :date
  end
end
