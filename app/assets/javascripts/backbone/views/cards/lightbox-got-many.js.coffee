BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxGotManyView extends BancoChile.Views.Cards.LightboxContent
  template: JST["backbone/templates/cards/lightbox-got-many"]

  render: ->
    @friends = @user.friendsWithoutCard(@card)
    super()

  cardSelected: (selectedSmallCardItemView)->
    @cardToGive = @card
    @cardToReceive = selectedSmallCardItemView.model
    super(selectedSmallCardItemView)

  userSelected: (user)->
    $(@el).find(".js-trade-cards").show()
    $(@el).find(".js-trade-friends").hide()
    $cardList = $(@el).find(".js-trade-card-list")
    @smallCardItemViewList = []

    for card in user.get('cards').models
      # if the other user does not have a repeated card to trade
      if card.get('count') < 2
        continue

      smallCardItemView = new BancoChile.Views.Cards.SmallCardItemView(
        model: card
      )
      @smallCardItemViewList.push(smallCardItemView)
      $cardList.append(smallCardItemView.render().el)
      smallCardItemView.bind("smallCardItemViewClicked", @cardSelected, this)
    return this
