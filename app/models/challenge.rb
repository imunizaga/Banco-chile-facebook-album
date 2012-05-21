class Challenge < ActiveRecord::Base
  attr_accessible :description, :n_cards, :name, :type
end
