BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxContent extends Backbone.View
  initialize: () ->
    @card = @options.card
    @user = @options.user

  events:
    "click .js-confirm": "confirm"

  render: ->
    $(@el).html(@template(card: @card.toJSON()))

    for friend in @friends
      smallRankingItemView = new BancoChile.Views.Users.SmallRankingItemView(
        user: friend
      )
      smallRankingItemView.bind("smallRankingUserClicked", @userSelected, this)
      $(@el).find('.js-friend-list').append(smallRankingItemView.render().el)

    return this

  cardSelected: (selectedSmallCardItemView)->
    # de-select all cards
    for smallCardItemView in @smallCardItemViewList
      $(smallCardItemView.el).removeClass('selected')

    # select the clicked card
    $(selectedSmallCardItemView.el).addClass('selected')

    console.log("trade " + @cardToGive.get('card_id') + " for " + @cardToReceive.get('card_id'))

  confirm: () ->
    $error = $(@el).find('.js-confirm-error')
    $error.hide()
    if @cardToGive and @cardToReceive and @selectedUser
      notification = new BancoChile.Models.Notification(
        user_id: @selectedUser.get('id')
        cards_in: [@cardToGive.get('card_id')]
        cards_out: [@cardToReceive.get('card_id')]
      )

      notification.save()
      toast('submitting trade', 'user')
    else
      if not @selectedUser
        $error.html(BancoChile.UIMessages['TRADE_ERROR_NO_USER'])
      else
        $error.html(BancoChile.UIMessages['TRADE_ERROR_NO_CARD'])
      $(@el).find('.js-confirm-error').show()

