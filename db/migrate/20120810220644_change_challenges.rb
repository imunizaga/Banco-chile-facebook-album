class ChangeChallenges < ActiveRecord::Migration
  def up
    begin
      challenge_client_param = {
        'method' => 'feed',
        'link' => 'http://apps.facebook.com/elequipodetodos/',
        'picture' => 'http://www.elequipodetodos.cl/assets/iconoBanco.jpg',
        'name' => '&Aacute;lbum el equipo de todos',
        'caption' => '&#161;Colecciona a tus jugadores favoritos!',
        'description' => 'Ya comenc&eacute; a coleccionar a mis jugadores favoritos. Participa t&uacute; tambi&eacute;n en el nuevo &aacute;lbum de la selecci&oacute;n EL EQUIPO DE TODOS http://www.elequipodetodos.cl/'
      }
      share_challenge1 = Challenge.find(11)
      share_challenge1.description = ""
      share_challenge1.client_param = ActiveSupport::JSON.encode(challenge_client_param)
      share_challenge1.save()

      challenge_client_param = {
        'method' => 'feed',
        'link' => 'http://apps.facebook.com/elequipodetodos/',
        'picture' => 'http://www.elequipodetodos.cl/assets/iconoBanco.jpg',
        'name' => '&Aacute;lbum el equipo de todos',
        'caption' => 'Participa t&uacute; tambi&eacute;n en el nuevo &aacute;lbum de la selecci&oacute;n',
        'description' => '&#161;Colecciona a tus jugadores favoritos! Consigue las l&aacute;minas y completa el &aacute;lbum EL EQUIPO DE TODOS http://www.elequipodetodos.cl/'
      }

      share_challenge2 = Challenge.find(13)
      share_challenge2.description = ""
      share_challenge2.client_param = ActiveSupport::JSON.encode(challenge_client_param)
      share_challenge2.save()

      retweet_challenge1 = Challenge.find(10)
      retweet_challenge1.server_param = 'elequipodetodos+from:bancodechile'
      retweet_challenge1.save()

      retweet_challenge2 = Challenge.find(12)
      retweet_challenge2.server_param = 'elequipodetodos+from:bancajoven'
      retweet_challenge2.save()
    rescue Exception
    end
  end

  def down
  end
end
