class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: 646008286
    twitter_id: null
    name: null

  initialize: () ->
    cards = new BancoChile.Collections.CardsCollection()
    @set('cards', cards)
    cards.bind('reset', @updateUniqueCardCount, this)

  updateUniqueCardCount: () ->
    uniqueCardsCount = 0
    cards = @get('cards')
    for card in cards.models
      if card.get('count')
        uniqueCardsCount++

    @set('unique_cards_count', uniqueCardsCount)

  isAuthenticated:() ->
    loginStatus = @get('login_status')

    if loginStatus is 'connected'
      return true
    return false

  getProfileImage: () ->
    image =  "https://graph.facebook.com/" + @get('facebook_id')
    return image + "/picture?height=45&width=45"

  getSmallProfileImage: () ->
    image =  "https://graph.facebook.com/" + @get('facebook_id')
    return image + "/picture?height=25&width=25"

  toJSON: () ->
    jsonUser = super()
    jsonUser.profile_image = @getProfileImage()
    jsonUser.small_profile_image = @getSmallProfileImage()
    return jsonUser

  friendsWithCard: (card) ->
    return window.app.ranking

  friendsWithoutCard: (card) ->
    return window.app.ranking

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
