class AlbumController < ApplicationController
  def home
    @api = Koala::Facebook::API.new(session[:access_token])
    if @api == nil
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
    if session['id'] == nil
      session['id_return'] ='/album/home'
      redirect_to :root and return
    end 
    @user=User.find(session['id'])
    @cards = Card.all
  end
end