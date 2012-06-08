class Notifications < ActiveRecord::Base
  attr_accessible :title, :description, :details, :user_id
  belongs_to :user
end
