BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxContent extends Backbone.View
  initialize: () ->
    @card = @options.card
    @user = @options.user

  events:
    "click .js-confirm": "confirm"

  render: ->
    $(@el).html(@template(card: @card.toJSON()))
    friendsWithCard = @user.friendsWithCard(@card)


    for friend in friendsWithCard.models
      smallRankingItemView = new BancoChile.Views.Users.SmallRankingItemView(
        user: friend
      )
      smallRankingItemView.bind("smallRankingUserClicked", @userSelected, this)
      $(@el).find('.js-friend-list').append(smallRankingItemView.render().el)
    return this

  confirm: () ->
    $(@el).find('.js-confirm-error').hide()
    if @cardToGive and @cardToReceive
      console.log('submitting trade')
    else
      $(@el).find('.js-confirm-error').show()

