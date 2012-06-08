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
        card = owner.album[self.card_id - 1]
        if card[:count] == 0 or card[:count] == nil
          owner.cards_count += 1
          owner.album[self.card_id - 1][:count] = 1
        else
          owner.album[self.card_id - 1][:count] += 1
        end
        owner.save
        rescue Exception=>ex
          puts 'Can\'t update user counts. Id:', owner.id, ex.message
      end
    end
end
