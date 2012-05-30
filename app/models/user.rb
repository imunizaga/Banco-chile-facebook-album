class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true

  def n_cards
    self.cards.count
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
