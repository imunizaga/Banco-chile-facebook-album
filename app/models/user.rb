class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  serialize :album, Array
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
  has_many :notifications
  before_create :set_empty_album

  def set_album
    options = {
      :include=>"user_cards", 
      :group=>"card_id"
    }
    cards= self.user_cards.count(options)
    raw_album = Array.new(Card.count,0)
    cards.each {|card| raw_album[card[0]-1] = card[1].to_i}
    user_album = []
    (1..raw_album.length).each do |i|
      hsh = Hash.new
      hsh[:card_id] = i
      hsh[:count] = raw_album[i-1]
      user_album.append(hsh)
      p hsh
    end
    self.album = user_album
    self.save
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
    q_users= User.select('id, facebook_id, name').where(:id => raw_ranking.transpose[0])
    ranking=[]
    (0..raw_ranking.length-1).each do |i|
      hsh = {
        :rank => i+1,
        :user_id => raw_ranking[i][0],
        :unique_cards_count => raw_ranking[i][1],
        :name => q_users.find_by_id(raw_ranking[i][0]).name,
        :facebook_id => q_users.find_by_id(raw_ranking[i][0]).facebook_id
      }
      ranking.append(hsh)
    end
    return ranking
  end
  
  def find_trades friends = User.where(Arel::Table.new(:users)[:id].not_in self.id)
    friends = friends.includes(:cards,:user_cards)
    self.album.each do |card|
      self.album[card[:card_id]-1][:trades] = []
      count = card[:count]
      trades = []
      case 
        when count == 0 then 
          print self.name, " doesn\'t have card ", card[:card_id],"\n"
          friends.each do |friend|
            if friend.album[card[:card_id]-1][:count] > 1
              self.album[card[:card_id]-1][:trades].append(friend.id) 
              print "\t", friend.name, " has card ", card[:card_id],  " repeated" ,"\n"
            end
          end
        when count > 1 then
          print self.name, " has card ", card[:card_id], " repeated", "\n"  
          friends.each do |friend|
            if card[:card_id].in? friend.remaining_cards.map {
              |friend_card| friend_card[:card_id] }
              self.album[card[:card_id]-1][:trades].append(friend.id) 
              print "\t", friend.name, " doesn\'t have card ", card[:card_id],  "\n"
            end
          end
        else
          print self.name, " has card ", card[:card_id], "\n"
          friends.each do |friend|
            if card[:card_id].in? friend.cards.map { |friend_card| friend_card[:id]}
              print "\t", friend.name, " also has this card \n"
              self.album[card[:card_id]-1][:trades].append(friend.id) 
            end
          end
      end
    end
    self.save
  end    
#    if self.repeated_cards.length <=  self.remaining_cards.length
#      self.remaining_cards.each do |card|
#        puts 'looking for card ', card[:card_id]
#        friends.each do |friend|
#          if card[:card_id].in? friend.repeated_cards.map {|card| card[:card_id] }
#            puts 'friend has this card repeated. Id: ', friend.id
#          end
#        end
#      end
#    else
#      p 'TODO: self.repeated_cards.length > self.remaining_cards.length'
#    end
#  end

  def self.sort_by_rank top
    User.order('-cards_count').limit(top)
  end

  def repeated_cards
    self.album.select{|card| card[:count]>1}
  end

  def remaining_cards
    self.album.select{|card| card[:count]==0}
  end

  def set_empty_album
    self.album = (1..Card.count).map { |i| {:card_id=>i, :count=>0 }}
  end

end
