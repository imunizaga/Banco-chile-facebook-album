class Challenge < ActiveRecord::Base
  attr_accessible :description, :n_cards, :name, :set, :kind, :client_param, :server_param
  has_many :card_packs
end
