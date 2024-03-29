# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
  ['Barra', 'lamina24Barra.jpg'],
  ['Oficial', 'lamina25Oficial.jpg'],
  ['Suazo', 'lamina26Suazo.jpg'],
  ['Vidal', 'lamina27Vidal.jpg'],
  ['Borghi', 'lamina28Borghi.jpg'],
  ['Paredes', 'lamina29Paredes.jpg'],
  ['Bravo', 'lamina30Bravo.jpg'],
  ['Gary', 'lamina31Gary.jpg'],
  ['DiegoRubio', 'lamina32DiegoRubio.jpg'],
  ['Alexis', 'lamina33Alexis.jpg'],
  ['Suazo', 'lamina34Suazo.jpg'],
  ['Vidal', 'lamina35Vidal.jpg'],
  ['Isla', 'lamina36Isla.jpg'],
  ['MatiFernadez', 'lamina37MatiFernadez.jpg'],
  ['Matias', 'lamina38Matias.jpg'],
  ['Alexis', 'lamina39Alexis.jpg'],
  ['Gary', 'lamina40Gary.jpg'],
  ['Toro', 'lamina41Toro.jpg'],
  ['Gary', 'lamina42Gary.jpg'],
  ['MDiaz', 'lamina43MDiaz.jpg'],
  ['Ponce', 'lamina44Ponce.jpg'],
  ['EduVargas', 'lamina45EduVargas.jpg'],
  ['ChAranguiz', 'lamina46ChAranguiz.jpg'],
  ['OGonzalez', 'lamina47OGonzalez.jpg'],
  ['Alexis', 'lamina48Alexis.jpg'],
  ['EduVargas', 'lamina49EduVargas.jpg'],
  ['Vidal', 'lamina50Vidal.jpg']
]

card_seeds.each {|card| Card.create(name: card[0], source: card[1])}

# 1
Challenge.create(
  n_cards:1,
  kind: 'join',
  description: "Registrate en la aplicaci&oacute;n",
  client_param: '',
  server_param: '',
  set: '[2,3,4,5,6,7]'
)
# 2
Challenge.create(
  n_cards:1,
  kind: 'like',
  description: "Banco de chile en Facebook",
  client_param: 'https://www.facebook.com/bancochile.cl',
  server_param: '57173152417',
  set: '[1]'
)
# 3
Challenge.create(
  n_cards:1,
  kind: 'like',
  description: "Este Album",
  client_param: 'http://bancochilealbum.herokuapp.com/',
  server_param: '478302348854060',
  set: '[33]'
)
# 4
Challenge.create(
  n_cards:1,
  kind: 'like',
  description: "Banca Joven en Facebook",
  client_param: 'https://www.facebook.com/BancaJoven',
  server_param: '300723886643482',
  set: '[37]'
)
# 5
Challenge.create(
  n_cards:1,
  kind: 'follow',
  description: "bancodechile",
  client_param: '14114282',
  set: '[35]'
)
# 6
Challenge.create(
  n_cards:1,
  kind: 'follow',
  description: "bancajoven",
  client_param: '14277567',
  set: '[26]'
)
# 7
Challenge.create(
  n_cards:1,
  kind: 'invite',
  description: "un amigo",
  client_param: '1',
  set: '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30]',
  repeatable: true
)
# 8
Challenge.create(
  n_cards:1,
  kind: 'code',
  description: "el muro de Banco de Chile",
  client_param: '',
  server_param: 'viva Chile',
  set: '[17]'
)
# 9
Challenge.create(
  n_cards:1,
  kind: 'code',
  description: "la p&aacute;gina de la Banca Joven",
  client_param: '',
  server_param: 'vamos Chile',
  set: '[8]'
)
# 10
Challenge.create(
  n_cards:1,
  kind: 'retweet',
  description: "un tweet del Banco de Chile",
  client_param: '230313801784897537',
  server_param: 'elequipodetodos+from:bancodechile',
  set: '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30,31,32,34,36,38,39,40,41,42,43,44,45,46,47,48,49,50]',
  repeatable: true
)
# 11
challenge_client_param = {
  'method' => 'feed',
  'link' => 'http://apps.facebook.com/elequipodetodos/',
  'picture' => 'http://www.elequipodetodos.cl/assets/iconoBanco.jpg',
  'name' => '&Aacute;lbum el equipo de todos',
  'caption' => '&#161;Colecciona a tus jugadores favoritos!',
  'description' => 'Ya comenc&eacute; a coleccionar a mis jugadores favoritos. Participa t&uacute; tambi&eacute;n en el nuevo &aacute;lbum de la selecci&oacute;n EL EQUIPO DE TODOS http://www.elequipodetodos.cl/'
}
Challenge.create(
  n_cards:1,
  kind: 'share',
  description: "",
  client_param: ActiveSupport::JSON.encode(challenge_client_param),
  set: '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30,31,32,34,36,38,39,40,41,42,43,44,45,46,47,48,49,50]',
  repeatable: true
)
# 12
Challenge.create(
  n_cards:1,
  kind: 'retweet',
  description: "un tweet de la Banca Joven",
  client_param: '230067273283543041',
  server_param: 'elequipodetodos+from:bancajoven',
  set: '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30,31,32,34,36,38,39,40,41,42,43,44,45,46,47,48,49,50]',
  repeatable: true
)
# 13
challenge_client_param = {
  'method' => 'feed',
  'link' => 'http://apps.facebook.com/elequipodetodos/',
  'picture' => 'http://www.elequipodetodos.cl/assets/iconoBanco.jpg',
  'name' => '&Aacute;lbum el equipo de todos',
  'caption' => 'Participa t&uacute; tambi&eacute;n en el nuevo &aacute;lbum de la selecci&oacute;n',
  'description' => '&#161;Colecciona a tus jugadores favoritos! Consigue las l&aacute;minas y completa el &aacute;lbum EL EQUIPO DE TODOS http://www.elequipodetodos.cl/'
}
Challenge.create(
  n_cards:1,
  kind: 'share',
  description: "",
  client_param: ActiveSupport::JSON.encode(challenge_client_param),
  set: '[2,3,4,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,28,29,30,31,32,34,36,38,39,40,41,42,43,44,45,46,47,48,49,50]',
  repeatable: true
)
# 14
Challenge.create(
  n_cards:1,
  kind: 'code',
  description: "el estadio del partido entre Chile y Colombia",
  client_param: '',
  server_param: 'Chile al mundial',
  set: '[25]',
)
