class StaticPagesController < ApplicationController
  def home
    @ranking = User.ranking
    @user = nil
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      if @user
        @user[:notifications] = @user.notifications
        @user[:login_status] = 'connected'

        if @user.tw_access_token
          @user[:twitter_connected] = true
        else
          @user[:twitter_connected] = false
        end

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
          @user['friends'] = friends
        end

        @cards = Card.all
        @challenges = Challenge.all_without_server_params(session)
        @user_challenges = UserChallenge.where(user_id:@user[:id])

        @user.fb_access_token = ""
        @user.tw_access_token = ""
      else
        session[:id] = nil
      end
    end

    # if the user was not found
    if @user == nil
      @user = {}

      # we now check weather we got a request
      @user[:request_ids] = params[:request_ids]
      request_id = params[:request_ids]
      if request_id
        @api = Koala::Facebook::API.new(session[:access_token])
        url = request_id
        params = "?access_token=#{session[:access_token]}"
        result = @api.get_connections(url, params)

        if result
          session[:from_id] = result['from']['id']
          session[:request_id] = request_id
        end
      end

    end
  end

  def help
  end

end
