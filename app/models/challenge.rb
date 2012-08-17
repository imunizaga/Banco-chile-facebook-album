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
  def validate_complete session, user, data
    # search if the user had already done this challenge
    user_challenge = UserChallenge.where(user_id: user.id,
                                         challenge_id: self.id).first
    # if he already has done this challenge
    if user_challenge

      # see if the challenge is repeatable
      if self.repeatable
        # if the challenge is still "locked"
        if user_challenge.updated_at > Date.today()
          wait_time = Date.tomorrow.to_time - user_challenge.updated_at
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

    return  self.send(method_name, session, user, data)
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
  def validate_like session, user, data
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
  def validate_follow session, user, data
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET,
                                {
                                  :site => 'https://twitter.com',
                                  :scheme => :header
                                })

    if session[:tw_access_token]
      tw_access_token = session[:tw_access_token]
    else
      token_hash = JSON.parse(user.tw_access_token)
      tw_access_token = OAuth::AccessToken.from_hash(oauth, token_hash)
    end

    # Perform action through a post call to the Twitter API
    # See https://dev.twitter.com/docs/api/1/post/friendships/create
    response = oauth.request(:post, '/friendships/create.json',
                             tw_access_token,
                             {:scheme => :query_string},
                             {:user_id => client_param})

    # The response can be parsed to confirm the followed account
    follow_info = JSON.parse(response.body)

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
  def validate_share session, user, data
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
  def validate_invite session, user, data

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
  def validate_retweet session, user, data
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET,
                                {
                                  :site => 'https://twitter.com',
                                  :scheme => :header
                                })

    if session[:tw_access_token]
      tw_access_token = session[:tw_access_token]
    else
      token_hash = JSON.parse(user.tw_access_token)
      tw_access_token = OAuth::AccessToken.from_hash(oauth, token_hash)
    end

    retweet_info = self.retweet(tw_access_token, oauth)

    is_retweet_info_valid = self.is_retweet_info_valid(retweet_info)

    if is_retweet_info_valid[:success]
      return is_retweet_info_valid
    else
      if retweet_info["errors"].class == Array
        if retweet_info["errors"][0].include?("code")
          if retweet_info["errors"][0]["code"] == 34
            self.update_retweet(session, true)
            retweet_info = self.retweet(tw_access_token, oauth)
            is_retweet_info_valid = self.is_retweet_info_valid(retweet_info)
          end
        end
      end
    end
    return is_retweet_info_valid
  end

  def retweet tw_access_token, oauth
    # Perform action through a post call to the Twitter API
    # See https://dev.twitter.com/docs/api/1/post/statuses/retweet/%3Aid
    response = oauth.request(:post,
                             "/statuses/retweet/#{self.client_param}.json",
                             tw_access_token,
                             { :scheme => :query_string })
    # The response can be parsed to confirm the retweeted id
    return JSON.parse(response.body)
  end

  def is_retweet_info_valid retweet_info
    if retweet_info.include?("errors")
      error_text = "sharing is not permissable for this status (Share validations failed)\nsharing is not permissable for this status (Share validations failed)\nsharing is not permissable for this status (Share validations failed)"

      if retweet_info["errors"] == error_text
        return {:success=> true}
      else
        return {:success=> false, :reason=>"invalid_tweet"}
      end
    end
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
  def validate_code session, user, data
    if self[:server_param] == data
      return {:success=> true}
    else
      return {:success=> false, :reason=>"invalid_code"}
    end
  end

  def update_retweet session, force=false
    t = self.updated_at + 1.days
    # if we need to update the tweet
    if Time.now > t or force
      params = {:site => 'https://twitter.com'}
      oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET, params)

      # Perform action through a post call to the Twitter API
      url = "/search.json?q=%23#{self.server_param}"
      response = oauth.request(:get, url,
                               session[:tw_access_token],
                               { :scheme => :query_string })

      # The response can be parsed to confirm the retweeted id
      tweets_info = JSON.parse(response.body)
      if tweets_info["results"].length > 0
        result = tweets_info["results"][0]
        tweet_id = result["id_str"]
        self.client_param = tweet_id
        self.save()
      end
    end
  end

  # Public: Returns a list of all challenges without the server_params value.
  # This is useful to send to the user without risks
  #
  # Returns an Array of Challenge objects
  def self.all_without_server_params session
    to = 7
    today = Date.today
    openSecondCardGroupDate = Date.new(2012,8,27)
    allCardsOpenDate = Date.new(2012,9,10)
    closingDate = Date.new(2012,9,15)

    if today > closingDate
      # cut the game
      return []
    end
    if today >= openSecondCardGroupDate
      # every challenge except the last one
      to = 13
    end
    if today >= allCardsOpenDate
      to = 14
    end
    challenges = self.where("id > 1 AND id <= #{to}")
    for challenge in challenges
      if challenge.kind == "retweet"
        challenge.update_retweet(session)
      end
      challenge[:server_param] = nil
    end
    return challenges
  end
end
