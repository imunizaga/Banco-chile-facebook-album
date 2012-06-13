class Notification < ActiveRecord::Base
  attr_accessible :title, :description, :details, :user_id, :cards_in, :cards_out
  belongs_to :user
end
