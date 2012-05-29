class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
end
