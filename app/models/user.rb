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

  # Public: Validates a trade of cards between the current user and another
  # user, and returns a boolean indicating if the trade can be made
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   validate_trade(1, "[3]", "[5]")
  #   # => false
  #
  # Returns A boolean indicating if the trade can be done
  def validate_trade sender_id, cards_in, cards_out
    trade = prepare_trade(sender_id, cards_in, cards_out)
    return if trade[:card_in] != nil and trade[:card_out] != nil
  end

  # Public: Prepares a trade of cards between the current user and another
  # user, and returns the cards to be traded
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   prepare_trade(1, "[3]", "[5]")
  #   # => [Card, Card]
  #
  # Returns An array with the cards to trade
  def prepare_trade sender_id, cards_in, cards_out

    # first decode the json strings we asume that only one card_id comes in
    # each array
    card_in_id = ActiveSupport::JSON.decode(cards_in)[0]
    card_out_id = ActiveSupport::JSON.decode(cards_out)[0]

    # fetch in my cards the card that will go out
    my_cards = self.user_cards.where(card_id: card_out_id)

    # fetch the card that will come in from the other user
    his_cards = UserCard.where(card_id: card_in_id, user_id: sender_id)

    # check if we both have enough cards
    if my_cards.count > 1 and  his_cards.count > 1 then
      # return the cards we are going to trade
      return {:card_in => his_cards.first, :card_out => my_cards.first}
    else
      # return an array of nils, indicating that no cards can be traded
      return {:card_in => nil, :card_out => nil}
    end
  end

  # Public: trades an array of cards between the current user and another
  # user, and returns true if the trade was completed
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   trade_card(1, "[3]", "[5]")
  #   # => [Card, Card]
  #
  # Returns A boolian indicating if the trade was successfull
  def trade_card sender_id, cards_in, cards_out
    # obtian the actual cards to be trade
    trade = self.prepare_trade(sender_id, card_in_id, card_out_id)
    card_in = trade[:card_in]
    card_out = trade[:card_out]

    # if the trade was validated
    if card_in != nil and card_out != nil then

      # obtain the sender
      sender = User.find(sender_id)

      # update the owners
      card_in.user = self
      card_out.user = sender
      card_in.save
      card_out.save

      # update the user data
      self.set_album
      sender.set_album
      return true
    end

    # if we  reach this point, then we everything failed
    puts "Can't make trade"
    return false
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
