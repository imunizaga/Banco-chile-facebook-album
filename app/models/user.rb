class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
  scope :ordered_by_ncards, order {-cards.count}

  def n_cards
    self.cards.count
  end

  def self.ranking
    ranking = self.ordered_by_ncards.map {|user|{:id=>user.id, :ncards=>user.cards.count}}
  end
end
