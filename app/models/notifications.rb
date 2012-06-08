class Notification < ActiveRecord::Base
  attr_accessible :title, :description, :details, :n_cards
end
