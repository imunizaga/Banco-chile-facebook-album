class StaticPagesController < ApplicationController
  def home
    @cards = Card.all
    @ranking = User.ranking
    puts "id: #{session[:id]}"
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      @user['login_status'] = 'connected'
      @user_album = @user.album
    else
      @user = {}
      @user_album = {}
    end
  end

  def help
  end

end
