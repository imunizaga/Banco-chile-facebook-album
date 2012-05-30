class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: null
    twitter_id: null
    name: null

  initialize: () ->
    @cards = new BancoChile.Collections.CardsCollection()

  updateUniqueCardCount: () ->
    uniqueCardsCount = 0
    cardsCount = @get('cardsCount')
    for cardCount in cardsCount
      if cardCount
        uniqueCardsCount++

    @set('uniqueCardsCount', uniqueCardsCount)

  isAuthenticated:() ->
    loginStatus = @get('loginStatus')

    if loginStatus is 'connected'
      return true
    return false

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
