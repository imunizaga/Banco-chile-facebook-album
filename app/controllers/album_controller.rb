class AlbumController < ApplicationController
  def home
    @api = Koala::Facebook::API.new(session[:access_token])
    if session[:callback_return]  == nil
      session[:callback_return] = '/album/home'
      redirect_to '/auth/facebook?permissions=user_about_me' and return
    end
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
    @user=User.find(2)
    @cards=@user.user_cards
    puts @cards
  end
end
