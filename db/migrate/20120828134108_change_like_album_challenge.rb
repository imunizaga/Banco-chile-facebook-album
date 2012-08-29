class ChangeLikeAlbumChallenge < ActiveRecord::Migration
  def up
    begin
      like_challenge = Challenge.find(3)
      like_challenge.client_param = 'http://www.elequipodetodos.cl/'
      like_challenge.server_param = '446490652062870',
      like_challenge.save()
    rescue Exception
    end
  end

  def down
  end
end
