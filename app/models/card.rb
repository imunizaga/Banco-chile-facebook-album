class Card < ActiveRecord::Base
  attr_accessible :info, :name, :set, :source
  has_many :user_cards
  has_many :users, :through => :user_cards
end
