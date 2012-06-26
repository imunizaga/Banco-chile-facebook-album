class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  serialize :album, Array
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
  has_many :notifications
  before_create :set_empty_album
  after_create :assign_first_card

  def set_album
    options = {
      :include=>"user_cards", 
      :group=>"card_id"
    }
    cards= self.user_cards.count(options)
    raw_album = Array.new(Card.count,0)
    cards.each {|card| raw_album[card[0]-1] = card[1].to_i}
    p raw_album
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

  def validate_trade sender_id, cards_in_id, cards_out_id
    cards_in = UserCard.where(id: cards_in_id, user_id: sender_id)
    cards_out = self.user_cards.where(id: cards_out_id)

    if cards_in.count > 1 and  cards_out.count > 1 then 
      return [cards_in.first,cards_out.first]
    else 
      return [nil, nil]
    end
  end

  def trade_card sender_id, card_in_id, card_out_id
    card_in, card_out = self.validate_trade(sender_id, card_in, card_out)
    if card_in != nil and card_out != nil then
      p card_in, card_out
      sender = User.where(id: sender_id)
      card_in.user = self
      card_out.user = sender
      card_in.save
      card_out.save
    self.save
    else
      puts "Can't make trade"
    end    
  end

  def self.ranking n = User.count
    options = {
      :select => 'id, facebook_id, name, cards_count',
      :order => '-cards_count', 
      :limit => n,
    }
    top_users = User.find(:all, options)
    ranking=[]
    (0..n-1).each do |rank|
      user_info = {
        :rank => rank+1,
        :user_id => top_users[rank].id,
        :unique_cards_count => top_users[rank].cards_count,
        :name => top_users[rank].name,
        :facebook_id => top_users[rank].facebook_id
      }
      ranking.append(user_info)
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

  def assign_first_card
    cardpack = CardPack.new(challenge_id:1)
    cardpack.user = self
    cardpack.save
  end

end
