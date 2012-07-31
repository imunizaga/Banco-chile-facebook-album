class CardPack < ActiveRecord::Base
  attr_accessible :challenge_id, :user_id
  has_many :user_cards
  belongs_to :challenge
  belongs_to :user
  after_create :create_cards
  after_save :check_cards_count

  private
    def check_cards_count
      begin
        owner = self.user
        cards_count = owner.cards_count
        self.user_cards.find_each do |user_card|
          card = owner.album[user_card.card_id - 1]
          if card[:count] == 0 or card[:count] == nil
            owner.cards_count += 1
            owner.album[user_card.card_id - 1][:count] = 1
          else
            owner.album[user_card.card_id - 1][:count] += 1
          end
        end
        owner.save
        rescue Exception=>ex
          print 'Can\'t update user counts.'
          if !owner then print "No user.\n" end
      end
    end

    def create_cards
      if self.challenge != nil and self.user != nil

        # we are going to log that this user completed this challenge
        user_challenge = UserChallenge.where(user_id: self.user.id,
                             challenge_id: self.challenge.id).first
        if user_challenge
          # update the updated_at time
          user_challenge.updated_at = Time.now
          user_challenge.save
        else
          # create a new record indicating that the user completed this challenge
          UserChallenge.create(user_id: self.user.id,
                             challenge_id: self.challenge.id)
        end
        cards_count = Card.count
        challenge_cards = self.challenge.n_cards
        card_set = ActiveSupport::JSON.decode(self.challenge.set)
        rand_cards =  (1..challenge_cards).map {card_set.sample}
        self[:card_ids] = []
        rand_cards.each  do |card_id|
           user_card = UserCard.new
           user_card.card_pack = self
           user_card.card_id = card_id
           user_card.user = self.user
           user_card.save
           self[:card_ids].push(card_id)
           #if @user_card.save == nil
           #  format.html { render action: "new" }
           #  format.json { render json: @card_pack.errors, status: :unprocessable_entity }
           #end

        end
      end
    end
end
