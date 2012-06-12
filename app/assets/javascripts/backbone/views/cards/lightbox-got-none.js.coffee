BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxGotNoneView extends BancoChile.Views.Cards.LightboxContent
  template: JST["backbone/templates/cards/lightbox-got-none"]

  userSelected: (user)->
    $(@el).find(".js-trade-cards").show()
    $(@el).find(".js-trade-friends").hide()
    @selectedUser = user

  cardSelected: (selectedSmallCardItemView)->
    @cardToGive = selectedSmallCardItemView.model
    @cardToReceive = @card
    super(selectedSmallCardItemView)

  render: ->
    @friends = @user.friendsWithRepeatedCard(@card)
    super()
    $cardList = $(@el).find(".js-trade-card-list")

    @smallCardItemViewList = []
    for card in @user.get('cards').models
      # if we don't have a repeated card to trade
      if card.get('count') < 2
        continue
      smallCardItemView = new BancoChile.Views.Cards.SmallCardItemView(
        model: card
      )
      @smallCardItemViewList.push(smallCardItemView)
      $cardList.append(smallCardItemView.render().el)
      smallCardItemView.bind("smallCardItemViewClicked", @cardSelected, this)
    return this


