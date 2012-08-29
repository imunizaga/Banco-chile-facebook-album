class ChangeVariousChallenges < ActiveRecord::Migration
  def up
    begin
      chile_code_challenge = Challenge.find(8)
      chile_code_challenge.server_param = 'viva Chile',
      chile_code_challenge.save()

      joven_code_challenge = Challenge.find(9)
      joven_code_challenge.server_param = 'vamos Chile',
      joven_code_challenge.save()

      share_challenge = Challenge.find(13)
      share_challenge.delete()
    rescue Exception
    end
  end

  def down
  end
end
