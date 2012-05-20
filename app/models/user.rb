class User < ActiveRecord::Base
  attr_accessible :email, :id_facebook, :id_twitter, :name
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
end
