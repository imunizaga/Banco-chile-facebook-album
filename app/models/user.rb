class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true

  def n_cards
    self.cards.count
  end

  def album
    options = {
      :include=>"user_cards", 
      :group=>"card_id"
    }
    cards= self.user_cards.count(options)
    user_album = Array.new(Card.count,0)
    cards.each {|card| user_album[card[0]-1] = card[1]}
    return user_album
  end

  def self.ranking n=10
    options = {
      :include => 'user_cards',
      :select => 'user_cards.card_id',
      :group => 'users.id',
      :order => '1 DESC',
    }
    count(options).entries[0..n-1]
  end
end
