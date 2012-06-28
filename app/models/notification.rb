class Notification < ActiveRecord::Base
  attr_accessible :title, :description, :details, :user_id, :cards_in,
    :cards_out, :sender_id, :status, :challenge_id
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
  # Returns A boolean indicating if the trade can be done
  def validate_challenge user
      return true
  end

  # Public: Validates a trade of specified in the notification
  #
  # user - (optional) The User object that is refered in user_id. This
  #            parameter exists to avoid doing an innecesary query to de db
  #
  # Examples
  #
  #   notification.validate_trade()
  #   # => true
  #
  # Returns A boolean indicating if the trade can be done
  def validate_trade user

    # since the user parameter is optional, check if its nil
    if user != nil
      # if the user we got is not the user specified in user_id
      if user.id != notification.user_id
          return false
      end
    else
      user = User.find(notification.user_id)
    end
    sender_id = notification.sender_id
    cards_in = notification.cards_in
    cards_out = notification.cards_out

    return user.validate_trade(sender_id, cards_in, cards_out)
  end
end
