class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: 646008286
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
    loginStatus = @get('login_status')

    if loginStatus is 'connected'
      return true
    return false

  getProfileImage: () ->
    debugger
    image =  "https://graph.facebook.com/" + @get('facebook_id')
    return image + "/picture?height=45&width=45"

  toJSON: () ->
    jsonUser = super()
    jsonUser.profile_image = @getProfileImage()
    return jsonUser

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
