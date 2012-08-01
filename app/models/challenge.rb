class Challenge < ActiveRecord::Base
  attr_accessible :description, :n_cards, :name, :set, :kind, :client_param, :server_param, :repeatable
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
  #   # => {success: true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_complete user, data
    # search if the user had already done this challenge
    user_challenge = UserChallenge.where(user_id: user.id,
                                         challenge_id: self.id).first
    # if he already has done this challenge
    if user_challenge

      # see if the challenge is repeatable
      if self.repeatable
        # calculate the time when the challenge is free to be completed again
        free_at = user_challenge.updated_at + 1.days

        # if the challenge is still "lockded"
        if free_at > Time.now
          wait_time = free_at - Time.now
          return {:success=>false, :reason=>"wait", :data=>wait_time}
        end
      else
        # it was already completed and it's not repeatable
        return {:success=>false, :reason=>"completed"}
      end
    end

    # if we reach this point, then the challenge has not been completed or
    # it's a repeatable challenge that is free again

    # now dinamically call the method that validates the challenge
    method_name = "validate_#{self.kind}"

    return  self.send(method_name, user, data)
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_like user, data
    #@api = Koala::Facebook::API.new("127174043311|F6mjALyN9OCelH8dE1UtPTPl_4k")
    #url = "100004040536236/likes/#{self.server_param}"
    #puts "#{url}?access_token=127174043311|F6mjALyN9OCelH8dE1UtPTPl_4k"
    #result = @api.get_connections(url, "?access_token=127174043311|F6mjALyN9OCelH8dE1UtPTPl_4k")

    @api = Koala::Facebook::API.new(user[:fb_access_token])
    # link for the user-app-like
    url = "#{user.facebook_id}/likes/#{self.server_param}"
    result = @api.get_connections(url, "?access_token=#{user[:fb_access_token]}")


    # check that we got a valid result
    if result
      like =  result[0]
      # check that this user is the one that emited the share
      if self.server_param == like['id']
        return {:success=> true}
      end
    end
    return {:success=> false, :reason=>"invalid"}
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_follow user, data
    return {:success=> true}
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_share user, data
    @api = Koala::Facebook::API.new(user[:fb_access_token])
    result = @api.get_connections(data, "")
    client_param = ActiveSupport::JSON.decode(self.client_param)

    # check that we got a valid result
    if result
      # check that this user is the one that emited the share
      if user.facebook_id == result['from']['id'].to_i
        # check that this share is about his link
        if result['link'] == client_param['link']
          return {:success=> true}
        end
      end
    end
    return {:success=> false, :reason=> "invalid"}
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_invite user, data
    return {:success=> true}
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_retweet user, data
    return {:success=> true}
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
  #   # => {:success=>true}
  #
  # Returns A hash with the following structure:
  # {
  #   success: boolean, //indicating if the challenge was completed
  #   reason: string, // the reason for failure
  #   data: string // extra data when necesary
  # }
  def validate_code user, data
    if self[:server_param] == data
      return {:success=> true}
    else
      return {:success=> false, :reason=>"invalid_code"}
    end
  end

  # Public: Returns a list of all challenges without the server_params value.
  # This is useful to send to the user without risks
  #
  # Returns an Array of Challenge objects
  def self.all_without_server_params
    challenges = self.where('id > 1')
    for challenge in challenges
      challenge[:server_param] = nil
    end
    return challenges
  end
end
