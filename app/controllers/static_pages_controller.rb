class StaticPagesController < ApplicationController
  def home         
    @api = Koala::Facebook::API.new(session[:access_token])
    if session[:access_token]==nil
      redirect_to '/auth/facebook/'
    end
    begin
      @user = @api.get_object("me")
      @user['img'] = 'https://graph.facebook.com/' + @user['id'] + '/picture?type=square'
      @friends = @api.get_connections('me', 'friends').first(10)
      @friends_using_app = @api.fql_query("
        SELECT uid, name, is_app_user, pic_square 
        FROM user 
        WHERE uid 
        IN (
          SELECT uid2 
          FROM friend 
          WHERE uid1 = me()) 
          AND is_app_user = 1"
        )
      rescue Exception=>ex
      puts ex.message
    end
  end

  def help
  end

end
