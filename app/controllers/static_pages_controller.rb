class StaticPagesController < ApplicationController
  def home
    @ranking = User.ranking
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      @user[:notifications] = @user.notifications
      @user[:login_status] = 'connected'

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
      @challenges = Challenge.all_without_server_params
    else # the user is not logged
      @user = {}

      # we now check weather we got a request
      @user[:request_ids] = params[:request_ids]
      request_id = params[:request_ids]
      if request_id
        @api = Koala::Facebook::API.new(ACCESS_TOKEN)
        url = request_id
        params = "?access_token=#{ACCESS_TOKEN}"
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
