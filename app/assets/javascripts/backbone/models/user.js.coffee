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
    @url = "/users/#{@id}"
    @updateRelationships(@options)
    @updating = false
    @updatedAt = new Date()

  updateRelationships: (options)->
    if options['notifications']
      notifications = new BancoChile.Collections.NotificationsCollection(
        options['notifications'])
      @set('notifications', notifications)

    if options['album']
      #create a duplicate of the cards
      myCards = new BancoChile.Collections.CardsCollection(
        window.db.cards.toJSON())

      # fill the cards with my own data
      for myCardData in options['album']
        myCard = myCards.filter(myCardData['card_id'])
        myCard.set(myCardData)

      @set('cards', myCards)
      @updateUniqueCardCount()
      myCards.bind('reset', @updateUniqueCardCount, this)
      myCards.bind('change', @updateUniqueCardCount, this)

    if options['friends']
      friends = new BancoChile.Collections.UsersCollection(options['friends'])
      @set('friends', friends)

  getCard: (card_id) ->
    return @get('cards').filter(card_id)

  updateData: ()->
    now = new Date()
    if (now.getTime() - @updatedAt.getTime()) < 60000
      return 
    if not @updating
      @updating = true
      user = new BancoChile.Models.User({id: @id})
      user.fetch(
        success: ()=>
          @updating = false
          @updateRelationships(user.toJSON())
          @updatedAt = new Date()
      )

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

  tradeCards: (jsonCardsIn, jsonCardsOut) ->
    # get the card we are going to receive
    cards_in_ids = JSON.parse(jsonCardsIn)
    for card_in_id in cards_in_ids
      card_in = @getCard(card_in_id)

      #adjust the incoming card count
      card_in.set('count', card_in.get('count') + 1)

    # get the card we are going to send
    if jsonCardsOut
      cards_out_ids = JSON.parse(jsonCardsOut)
      for card_out_id in cards_out_ids
        card_out = @getCard(card_out_id)

        # adjust the incoming card count
        card_out.set('count', card_out.get('count') - 1)

    return true

class BancoChile.Collections.UsersCollection extends Backbone.Collection
  model: BancoChile.Models.User
  url: '/users'
