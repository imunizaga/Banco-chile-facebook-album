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
  ['carlos caszely',      100003281187419]
]

user_seeds.each {|user| User.create(name: user[0], facebook_id: user[1])}
card_seeds.each {|card| Card.create(name: card[0], source: card[1])}

Challenge.create(n_cards:1, name: 'mail')
Challenge.create(n_cards:3, name: 'invite')

CardPack.create(challenge_id:1)
UserCard.create(card_pack_id:1, card_id:1, user_id:1)

CardPack.create(challenge_id:1)
UserCard.create(card_pack_id:2, card_id:2, user_id:1)

CardPack.create(challenge_id:1)
UserCard.create(card_pack_id:3, card_id:3, user_id:2)

CardPack.create(challenge_id:1)
UserCard.create(card_pack_id:4, card_id:1, user_id:3)

CardPack.create(challenge_id:2)
UserCard.create(card_pack_id:5, card_id:3, user_id:4)
UserCard.create(card_pack_id:5, card_id:3, user_id:4)
UserCard.create(card_pack_id:5, card_id:3, user_id:4)

CardPack.create(challenge_id:2)
UserCard.create(card_pack_id:6, card_id:2, user_id:5)
UserCard.create(card_pack_id:6, card_id:3, user_id:5)
UserCard.create(card_pack_id:6, card_id:4, user_id:5)

CardPack.create(challenge_id:2)
UserCard.create(card_pack_id:7, card_id:5, user_id:5)
UserCard.create(card_pack_id:7, card_id:5, user_id:5)
UserCard.create(card_pack_id:7, card_id:5, user_id:5)

