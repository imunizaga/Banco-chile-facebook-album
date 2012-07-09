class StaticPagesController < ApplicationController
  def home
    @ranking = User.ranking
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      @user[:notifications] = @user.notifications
      @user[:login_status] = 'connected'

      # obtain the facebook friends
      @api = Koala::Facebook::API.new(session[:access_token])
      @user[:request_ids] = params[:request_ids]
      request_id = params[:request_ids]
      if request_id
        url = "#{request_id}_#{@user.facebook_id}"
        params = "?access_token=#{ACCESS_TOKEN}"
        puts url
        result = @api.get_connections(url, params)
        @user[:result] =  result
      end

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
    else
      @user = {}
    end
  end

  def help
  end

end
