class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :twitter_id, :name, :foursquare_id, :friends, :referals
  serialize :album, Array
  has_many :user_cards
  has_many :cards, :through => :user_cards, :uniq => true
  has_many :notifications
  before_create :set_empty_album
  after_create :assign_first_card

  # Public: Prepares a user object to be sended to the browser
  def prepare_to_send session, send_friends=true
    if self.id
      self[:notifications] = self.notifications
      self[:login_status] = 'connected'

      if self.tw_access_token
        self[:twitter_connected] = true
      else
        self[:twitter_connected] = false
      end

      if send_friends
        # obtain the facebook friends
        @api = Koala::Facebook::API.new(session[:access_token])
        if @api != nil
          friends_using_app = @api.fql_query("
              SELECT uid, name, is_app_user, pic_square
              FROM user
              WHERE uid
              IN (
                SELECT uid2
                FROM friend
                WHERE uid1 = me())
                AND is_app_user = 1"
          )
          # obtain the ruby users
          friends_fids = friends_using_app.map {|fb_friend| fb_friend['uid'] }
          friends = User.where(facebook_id: friends_fids)

          # adds the friends to the user
          self['friends'] = friends
        end
      end
    end
  end

  # Public: Creates a string representation of the album of the user, to
  # avoid doing user_cards queries
  def set_album

    # We want to count the user's cards and group them by id
    options = {
      :include=>"user_cards",
      :group=>"card_id",
      :conditions => {:locked => false}
    }
    cards= self.user_cards.count(options)

    # Within an array we will hold a hash for each card containing the
    # card id and the count
    self.set_empty_album()

    cards.each do |card|
      album[card[0]-1][:count] = card[1].to_i
    end

    self.save
    return self.album
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
    return trade[:valid]
  end

  # Public: Prepares a trade proposal of cards between the current user and
  # another user, by checking that not-locked cards that both users have
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   user.prepare_trade(1, "[3]", "[5]")
  #   # => {:card_in => Card, :card_out => Card, :valid => true}
  #   or
  #   user.prepare_trade(1, "[3]", "[4]")
  #   # => {:card_in => nil, :card_out => nil, :valid => false}
  #
  # Returns A hash with the cards to trade and if the trade if valid
  def prepare_trade_proposal sender_id, cards_in, cards_out

    # first decode the json strings we asume that only one card_id comes in
    # each array
    card_in_id = ActiveSupport::JSON.decode(cards_in)[0]
    card_out_id = ActiveSupport::JSON.decode(cards_out)[0]

    # fetch in my cards the card that will go out
    my_cards = self.user_cards.where(card_id: card_out_id, locked: false)

    # fetch the card that will come in from the other user
    his_cards = UserCard.where(card_id: card_in_id, user_id: sender_id,
                               locked: false)

    # check if we both have enough cards
    if my_cards.count > 1 and  his_cards.count > 1 then
      # return the cards we are going to trade
      return {
        :card_in => his_cards.first,
        :card_out => my_cards.first,
        :valid => true,
        :reason => ""
      }
    else
      # return an array of nils, indicating that no cards can be traded
      return {
        :card_in => nil,
        :card_out => nil,
        :valid => false,
        :reason => [my_cards.count, his_cards.count]
      }
    end
  end

  # Public: Prepares a trade of cards between the current user and another
  # user by checking the locked cards
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   user.prepare_trade(1, "[3]", "[5]")
  #   # => {:card_in => Card, :card_out => Card, :valid => true}
  #   or
  #   user.prepare_trade(1, "[3]", "[4]")
  #   # => {:card_in => nil, :card_out => nil, :valid => false}
  #
  # Returns A hash with the cards to trade and if the trade if valid
  def prepare_trade sender_id, cards_in, cards_out

    # first decode the json strings we asume that only one card_id comes in
    # each array
    card_in_id = ActiveSupport::JSON.decode(cards_in)[0]
    card_out_id = ActiveSupport::JSON.decode(cards_out)[0]

    # fetch in my cards the card that will go out
    my_cards = self.user_cards.where(card_id: card_out_id, locked: false)

    # fetch the card that will come in from the other user. We need to check
    # they are locked since it's the user that locked a card to propose a
    # trade
    his_cards = UserCard.where(card_id: card_in_id, user_id: sender_id,
                               locked: true)

    # check if we both have enough cards
    if my_cards.count > 1 and  his_cards.count > 0 then
      # return the cards we are going to trade
      return {
        :card_in => his_cards.first,
        :card_out => my_cards.first,
        :valid => true,
        :reason => ""
      }
    else
      # return an array of nils, indicating that no cards can be traded
      return {
        :card_in => nil,
        :card_out => nil,
        :valid => false,
        :reason => [my_cards.count, his_cards.count]
      }
    end
  end

  # Public: trades an array of cards between the current user and another
  # user
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards to receive in json
  # card_out  - The String with the array of cards to give in json
  #
  # Examples
  #
  #   user.prepare_trade_hash(my_cards, his_cards)
  #   # => {:card_in => Card, :card_out => Card, :valid => true}
  #   or
  #   user.prepare_trade_hash(my_cards, his_cards)
  #   # => {:card_in => nil, :card_out => nil, :valid => false}
  #
  # Returns A hash with the cards to trade and if the trade if valid
  def trade_card sender_id, cards_in, cards_out
    # obtian the actual cards to be trade
    trade = self.prepare_trade(sender_id, cards_in, cards_out)
    card_in = trade[:card_in]
    card_out = trade[:card_out]

    # if the trade was validated
    if trade[:valid] then

      # obtain the sender
      sender = User.find(sender_id)

      # update the owners
      card_in.user = self
      card_out.user = sender

      #update the locks
      card_in[:locked] = false
      card_out[:locked] = false

      #save
      card_in.save
      card_out.save

      # update the user data
      self.set_album
      sender.set_album
    end
    return trade
  end

  # Public: denies a trade between the current user and another user
  #
  # sender_id  - The Integer number that represents the other user
  # cards_in  - The String with the array of cards the sender was giving in
  #             json
  #
  # Examples
  #
  #   user.deny_trade(sender_id, cards_in)
  #   # => {:valid => true}
  #   or
  #   user.deny_trade(sender_id, cards_in)
  #   # => {:valid => false, :reason => "no such trade"}
  #
  # Returns A hash with the cards to trade and if the trade if valid
  def deny_trade sender_id, cards_in
    # first decode the json strings we asume that only one card_id comes in
    # each array
    card_in_id = ActiveSupport::JSON.decode(cards_in)[0]

    # fetch the card that will come in from the other user. We need to check
    # they are locked since it's the user that locked a card to propose a
    # trade
    his_cards = UserCard.where(card_id: card_in_id,
                               user_id: sender_id,
                               locked: true)

    # unlock the locked card
    if his_cards.count > 0 then
      his_card = his_cards[0]
      his_card.locked = false
      his_card.save()
      sender = User.find(sender_id)
      sender.set_album
    end

    notification = Notification.create(
      description: " #{self.name} ha rechazado tu intercambio de cartas",
      user_id: sender_id,
      cards_out: cards_in
    )

    return {
      :valid => true,
      :reason => ""
    }
  end

  def self.ranking offset = 0, n = User.count
    if n > 32
      n = 32
    end

    options = {
      :select => 'id, facebook_id, name, cards_count',
      :order => '-cards_count',
      :limit => n,
      :offset => offset,
    }

    top_users = User.find(:all, options)
    print top_users
    ranking=[]
    (0..top_users.count-1).each do |rank|
      user_info = {
        :rank => rank+1+offset,
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
