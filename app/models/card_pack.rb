class CardPack < ActiveRecord::Base
  attr_accessible :challenge_id
  has_many :user_cards
  belongs_to :challenge
  belongs_to :user
  after_save :create_cards

  def create_cards
    if self.challenge != nil
      self.challenge.n_cards.times do 
         user_card = UserCard.new
         user_card.card_pack = self
         user_card.user = self.user
         user_card.card = Card.find(:first, :offset => rand(Card.count))
         user_card.save
         #if @user_card.save == nil
         #  format.html { render action: "new" }
         #  format.json { render json: @card_pack.errors, status: :unprocessable_entity }
         #end
      end
    end
  end
end
