class UserCard < ActiveRecord::Base
  attr_accessible :user_id, :card_id, :card_pack_id
  belongs_to :user
  belongs_to :card
  belongs_to :card_pack

  after_create :check_cards_count
  private
    def check_cards_count
      begin
        owner = self.user
        cards_count = owner.cards_count
        if owner.album[self.card_id - 1][:count] == 0
          owner.cards_count = owner.cards_count + 1
        end
        owner.album[self.card_id - 1][:count] += 1
        owner.save
        rescue Exception=>ex
          puts 'Can\'t update user counts. ', ex.message
      end
    end
end
