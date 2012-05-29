BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.AlbumView extends Backbone.View
  template: JST["backbone/templates/cards/album"]

  initialize: () ->
    @cards = @options.cards
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    $el = $(@el)
    $el.html(@template({}))
    $laminas = $el.find('.laminas')
    for card in @cards.models
      cardItemView = new BancoChile.Views.Cards.CardItemView(model: card)
      $laminas.append(cardItemView.render().el)

    return this
