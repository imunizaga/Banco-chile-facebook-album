class StaticPagesController < ApplicationController
  def home
    @cards = Card.all
    @ranking = User.ranking
    puts "id: #{session[:id]}"
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
    end
  end

  def help
  end

end
