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
  ['oliver atom',         53166931056],
  ['sapito livingstone',  106388642729768],
  ['pato yanez',          32423176720],
  ['condor rojas',        233877793326597],
  ['carlos caszely',      100003281187419],
  ['wooo',  807892319],
  ['nacho', 606953998],
  ['muni',  646008286],
  ['joao',  556381267],
  ['ale',   1029630749],
  ['johnny', 27542063907]
]

card_seeds.each {|card| Card.create(name: card[0], source: card[1])}
user_seeds.each {|user| User.create(name: user[0], facebook_id: user[1])}

# 1
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'https://www.facebook.com/pages/Oliver-Atom/53166931056',
  set: '[1]'
)
# 2
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'http://www.magnet.cl',
  set: '[2]'
)
# 3
Challenge.create(
  n_cards:3,
  kind: 'like',
  client_param: 'http://stackoverflow.com/',
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
  client_param: 'ignacio_parada',
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
  client_param: '213378589977100290',
  set: '[4, 1]'
)
# 10
Challenge.create(
  n_cards:5,
  kind: 'share',
  client_param: 'Facebook Banco Chile',
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
Challenge.create(
  n_cards:1,
  kind: 'share',
  client_param: 'Facebook Banca Joven',
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

Notification.create(user_id:1, sender_id:2, cards_in:'[2]', cards_out:'[1]')
Notification.create(user_id:2, sender_id:3, cards_in:'[3]', cards_out:'[2]')
Notification.create(user_id:3, sender_id:4, cards_in:'[4]', cards_out:'[3]')
Notification.create(user_id:4, sender_id:5, cards_in:'[5]', cards_out:'[4]')
Notification.create(user_id:5, sender_id:1, cards_in:'[1]', cards_out:'[5]')

Notification.create(user_id:1, description:'retweet', cards_in:'[1]')
Notification.create(user_id:2, description:'retweet', cards_in:'[2]')
Notification.create(user_id:3, description:'retweet', cards_in:'[3]')
Notification.create(user_id:4, description:'retweet', cards_in:'[4]')
Notification.create(user_id:5, description:'retweet', cards_in:'[5]')
