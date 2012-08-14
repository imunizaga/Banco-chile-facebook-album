class ChangeInviteChallengeCards < ActiveRecord::Migration
  def up
    begin
      invite_challenge = Challenge.find(7)
      invite_challenge.set = '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30]'
      invite_challenge.save()
    rescue Exception
    end
  end

  def down
  end
end
