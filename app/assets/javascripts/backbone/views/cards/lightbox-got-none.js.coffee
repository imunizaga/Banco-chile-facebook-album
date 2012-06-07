BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxGotNoneView extends BancoChile.Views.Cards.LightboxContent
  template: JST["backbone/templates/cards/lightbox-got-none"]

  userSelected: (user)->
    $(@el).find(".js-trade-cards").show()
    $(@el).find(".js-trade-friends").hide()

  cardSelected: (card)->
    @cardToGive = card
    @cardToReceive = @card
    console.log("trade " + @cardToGive.get('card_id') + " for " + @cardToReceive.get('card_id'))

  render: ->
    super()
    $cardList = $(@el).find(".js-trade-card-list")
    for card in @user.get('cards').models
      smallCardItemView = new BancoChile.Views.Cards.SmallCardItemView(
        model: card
      )
      $cardList.append(smallCardItemView.render().el)
      smallCardItemView.bind("smallCardItemViewClicked", @cardSelected, this)
    return this


