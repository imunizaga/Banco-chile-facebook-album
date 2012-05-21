class UserCard < ActiveRecord::Base
  attr_accessible :id, :user_id, :card_id,
  belongs_to :user
  belongs_to :card
  belongs_to :card_pack
end
