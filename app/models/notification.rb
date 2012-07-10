class Notification < ActiveRecord::Base
  attr_accessible :title, :description, :details, :user_id, :cards_in,
    :cards_out, :sender_id, :status, :challenge_id, :daasdf
  belongs_to :user

  # Public: Validates a that a challenge was completed acording to the
  # notification
  #
  # user - (optional) The User object that is refered in user_id. This
  #            parameter exists to avoid doing an innecesary query to de db
  #
  # Examples
  #
  #   notification.validate_challenge()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_challenge user=nil, data=nil
      challenge = Challenge.find(self.challenge_id)
      return challenge.validate_complete(user, data)
  end

  # Public: Prepares a trade of specified in the notification
  #
  # user - (optional) The User object that is refered in user_id. This
  #            parameter exists to avoid doing an innecesary query to de db
  #
  # Examples
  #
  #   notification.prepare_trade(1, "[3]", "[5]")
  #   # => {:card_in => Card, :card_out => Card, :valid => true}
  #   or
  #   notification.prepare_trade(1, "[3]", "[4]")
  #   # => {:card_in => nil, :card_out => nil, :valid => false}
  #
  # Returns A hash with the cards to trade and if the trade if valid
  def prepare_trade_proposal user=nil

    # since the user parameter is optional, check if its nil
    if user != nil
      # if the user we got is not the user specified in user_id
      if user.id != self.user_id
          return false
      end
    else
      user = User.find(self.user_id)
    end
    sender_id = self.sender_id
    cards_in = self.cards_in
    cards_out = self.cards_out

    return user.prepare_trade_proposal(sender_id, cards_in, cards_out)
  end
end
