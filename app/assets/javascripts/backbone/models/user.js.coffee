class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: null
    twitter_id: null
    name: null

  initialize: () ->
    @cards = new BancoChile.Collections.CardsCollection()

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
