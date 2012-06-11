class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: 646008286
    twitter_id: null
    name: null

  initialize: (@options) ->
    cards = new BancoChile.Collections.CardsCollection(@options['album'])
    @set('cards', cards)
    cards.bind('reset', @updateUniqueCardCount, this)

    friends = new BancoChile.Collections.UsersCollection(@options['friends'])
    @set('friends', friends)

  getCard: (card_id) ->
    return _.find(@get('cards').models, (card)->
      return card.get('card_id') == card_id
    )

  hasCard: (card) ->
    card = @getCard(card.get('card_id'))
    return card.get('count') == 1

  hasCardRepeated: (card) ->
    card = @getCard(card.get('card_id'))
    return card.get('count') > 1

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
    friendsWithCard = []
    for friend in @get('friends').models
      if friend.hasCard(card)
        friendsWithCard.push(friend)
    return friendsWithCard

  friendsWithRepeatedCard: (card) ->
    friendsWithRepeatedCard = []
    for friend in @get('friends').models
      if friend.hasCardRepeated(card)
        friendsWithRepeatedCard.push(friend)
    return friendsWithRepeatedCard

  friendsWithoutCard: (card) ->
    friendsWithoutCard = []
    for friend in @get('friends').models
      if not friend.hasCard(card)
        friendsWithoutCard.push(friend)
    return friendsWithoutCard

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
