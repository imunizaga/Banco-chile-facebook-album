class Challenge < ActiveRecord::Base
  attr_accessible :description, :n_cards, :name, :set, :kind, :client_param, :server_param
  has_many :card_packs

  # Public: Validates a that a challenge was completed by the especified user
  # acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_complete()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_complete user, data
    method_name = "validate_#{self.kind}"
    return self.send(method_name, user, data)
  end

  # Public: Validates a that a challenge of type like was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_like()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_like user, data
      return true
  end

  # Public: Validates a that a challenge of type follow was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_follow()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_follow user, data
    return true
  end

  # Public: Validates a that a challenge of type share was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_share()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_share user, data
    return true
  end

  # Public: Validates a that a challenge of type invite was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_invite()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_invite user, data
    return true
  end

  # Public: Validates a that a challenge of type retweet was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_retweet()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_retweet user, data
    return true
  end

  # Public: Validates a that a challenge of type code was completed by the
  # especified user acording to the data given
  #
  # user - The User object that is we are checking
  # data - a String that helps in the validation
  #
  # Examples
  #
  #   challenge.validate_code()
  #   # => true
  #
  # Returns A boolean indicating if the challenge was completed
  def validate_code user, data
    return true
  end

  # Public: Returns a list of all challenges without the server_params value.
  # This is useful to send to the user without risks
  #
  # Returns an Array of Challenge objects
  def self.all_without_server_params
    challenges = self.all
    for challenge in challenges
      challenge[:server_param] = nil
    end
    return challenges
  end
end
