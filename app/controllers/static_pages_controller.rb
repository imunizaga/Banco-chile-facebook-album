class StaticPagesController < ApplicationController
  def home
    @cards = Card.all
    @ranking = User.ranking
  end

  def help
  end

end
