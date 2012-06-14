class BancoChile.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    facebook_id: 646008286
    twitter_id: null
    name: null

  # as an optional parameter, the user can receive cards, thats
  # the collection of generic cards
  initialize: (@options) ->
    if @options['notifications']
      notifications = new BancoChile.Collections.NotificationsCollection(
        @options['notifications'])
      @set('notifications', notifications)

    if @options['album']
      #create a duplicate of the cards
      myCards = new BancoChile.Collections.CardsCollection(
        window.db.cards.toJSON())

      # fill the cards with my own data
      for myCardData in @options['album']
        myCard = myCards.filter(myCardData['card_id'])
        myCard.set(myCardData)

      @set('cards', myCards)
      @updateUniqueCardCount()
      myCards.bind('reset', @updateUniqueCardCount, this)
      myCards.bind('change', @updateUniqueCardCount, this)

    friends = new BancoChile.Collections.UsersCollection(@options['friends'])
    @set('friends', friends)

  getCard: (card_id) ->
    return @get('cards').filter(card_id)

  hasCard: (card) ->
    myCard = @getCard(card.get('card_id'))
    return myCard.get('count') == 1

  hasCardRepeated: (card) ->
    myCard = @getCard(card.get('card_id'))
    return myCard.get('count') > 1

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
