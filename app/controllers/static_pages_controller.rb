class StaticPagesController < ApplicationController
  def home
    @cards = Card.all
  end

  def help
  end

end
