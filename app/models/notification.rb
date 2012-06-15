class Notification < ActiveRecord::Base
  attr_accessible :title, :description, :details, :user_id, :cards_in, :cards_out, :sender_id
  belongs_to :user
end
