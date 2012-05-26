class UserCard < ActiveRecord::Base
  attr_accessible :user_id, :card_id, :card_pack_id
  belongs_to :user
  belongs_to :card
  belongs_to :card_pack
end
