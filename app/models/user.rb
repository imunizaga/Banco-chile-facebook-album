class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true

  cattr_accessor :album, :repeated_cards, :remaining_cards 

  def n_cards
    self.cards.count
  end

  def set_album
    options = {
      :include=>"user_cards", 
      :group=>"card_id"
    }
    cards= self.user_cards.count(options)
    raw_album = Array.new(Card.count,0)
    cards.each {|card| raw_album[card[0]] = card[1].to_i}
    user_album = []
    (1..raw_album.length-1).each do |i|
      hsh = Hash.new
      hsh[:card_id] = i
      hsh[:n] = raw_album[i]
      user_album.append(hsh)
      p hsh
    end
    return user_album
  end

  def self.ranking n=10
    options = {
      :include => 'user_cards',
      :select => 'user_cards.card_id',
      :group => 'users.id',
      :order => '1 DESC',
    }
    raw_ranking = User.count(options).entries[0..n-1]
    ranking=[]
    (0..raw_ranking.length-1).each do |i|
      hsh = {
        :rank => i+1,
        :user_id => raw_ranking[i][0],
        :unique_cards_count => raw_ranking[i][1]
      }
      ranking.append(hsh)
    end
    return ranking
  end
end
