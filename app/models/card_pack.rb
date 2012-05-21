class CardPack < ActiveRecord::Base
  attr_accessible :challenge_id
  has_many :user_cards
  belongs_to :users
end
