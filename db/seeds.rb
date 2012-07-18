# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_seeds = [
  ['wooo',  807892319],
  ['nacho', 606953998],
  ['muni',  646008286],
  ['joao',  556381267],
  ['ale',   1029630749],
  ['johnny', 27542063907]
]

card_seeds =[
  ['Bravo', 'lamina01Bravo.jpg'],
  ['Alexis', 'lamina02Alexis.jpg'],
  ['Celebracion', 'lamina03Celebracion.jpg'],
  ['Alexis', 'lamina04Alexis.jpg'],
  ['OGonzalez', 'lamina05OGonzalez.jpg'],
  ['JPFuenzalida', 'lamina06JPFuenzalida.jpg'],
  ['MCamposT', 'lamina07MCamposT.jpg'],
  ['Borghi', 'lamina08Borghi.jpg'],
  ['Alexis', 'lamina09Alexis.jpg'],
  ['Bravo', 'lamina10Bravo.jpg'],
  ['LJimenes', 'lamina11LJimenes.jpg'],
  ['Pinto', 'lamina12Pinto.jpg'],
  ['Barra', 'lamina13Barra.jpg'],
  ['MFernandez', 'lamina14MFernandez.jpg'],
  ['Alexis', 'lamina15Alexis.jpg'],
  ['Borghi', 'lamina16Borghi.jpg'],
  ['Gary', 'lamina17Gary.jpg'],
  ['Celebracion', 'lamina18Celebracion.jpg'],
  ['EVargas', 'lamina19EVargas.jpg'],
  ['NN', 'lamina20NN.jpg'],
  ['EParedes', 'lamina21EParedes.jpg'],
  ['DRubio', 'lamina22DRubio.jpg'],
  ['Pinto', 'lamina23Pinto.jpg'],
  ['Bravo', 'lamina30Bravo.jpg'],
  ['Gary', 'lamina40Gary.jpg']
]

card_seeds.each {|card| Card.create(name: card[0], source: card[1])}
user_seeds.each {|user| User.create(name: user[0], facebook_id: user[1])}

# 1
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'https://www.facebook.com/pages/Oliver-Atom/53166931056',
  server_param: '53166931056',
  set: '[1]'
)
# 2
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'http://www.facebook.com/apps/application.php?id=127174043311',
  server_param: '127174043311',
  set: '[2]'
)
# 3
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'https://www.facebook.com/pages/GitHub/50595864761',
  server_param: '50595864761',
  set: '[3]'
)
# 4
Challenge.create(
  n_cards:3,
  kind: 'follow',
  client_param: 'magnet_dev',
  set: '[4]'
)
# 5
Challenge.create(
  n_cards:3,
  kind: 'follow',
  client_param: 'github',
  set: '[5]'
)
# 6
Challenge.create(
  n_cards:5,
  kind: 'invite',
  client_param: '1',
  set: '[1, 3]'
)
# 7
Challenge.create(
  n_cards:5,
  kind: 'code',
  client_param: 'el muro de Banco de Chile',
  server_param: '12345',
  set: '[2, 4]'
)
# 8
Challenge.create(
  n_cards:5,
  kind: 'code',
  client_param: 'la p&aacute;gina de la Banca Joven',
  server_param: '54321',
  set: '[3, 5]'
)
# 9
Challenge.create(
  n_cards:5,
  kind: 'retweet',
  client_param: '208950770589114368',
  set: '[4, 1]'
)
# 10
challenge_client_param = {
  'method' => 'feed',
  'link' => 'http://www.magnet.cl/',
  'picture' => 'http://fbrell.com/f8.jpg',
  'name' => 'Magnet.cl',
  'caption' => 'Magnet.cl',
  'description' => 'Nueva empresa de desarrollo de software'
}
Challenge.create(
  n_cards:5,
  kind: 'share',
  client_param: ActiveSupport::JSON.encode(challenge_client_param),
  set: '[5, 2]'
)
# 11
Challenge.create(
  n_cards:1,
  kind: 'retweet',
  client_param: '213379847861436417',
  set: '[1, 2, 3, 4, 5]'
)
# 12
challenge_client_param = {
  'method' => 'feed',
  'link' => 'http://www.magnet.cl/',
  'picture' => 'http://fbrell.com/f8.jpg',
  'name' => 'Magnet.cl',
  'caption' => 'Magnet.cl',
  'description' => 'Nueva empresa de desarrollo de software'
}
Challenge.create(
  n_cards:1,
  kind: 'share',
  client_param: ActiveSupport::JSON.encode(challenge_client_param),
  set: '[6, 7, 8, 9, 10]'
)
# 13
Challenge.create(
  n_cards:1,
  kind: 'code',
  client_param: 'el estado del partido entre Chile y Colombia',
  server_param: '2 0 gana Chile',
  set: '[11]'
)

# user 1
CardPack.create(challenge_id:6, user_id: 1)

# user 2
CardPack.create(challenge_id:2, user_id: 2)

# user 3
CardPack.create(challenge_id:3, user_id: 3)

# user 4
CardPack.create(challenge_id:4, user_id: 4)

# user 5
CardPack.create(challenge_id:10, user_id: 5)

Notification.create(user_id:1, challenge_id:9, cards_in:'[1]')
Notification.create(user_id:2, challenge_id:9, cards_in:'[2]')
Notification.create(user_id:3, challenge_id:6, cards_in:'[3]')
Notification.create(user_id:3, challenge_id:9, cards_in:'[3]')
Notification.create(user_id:4, challenge_id:9, cards_in:'[4]')
Notification.create(user_id:5, challenge_id:9, cards_in:'[5]')
