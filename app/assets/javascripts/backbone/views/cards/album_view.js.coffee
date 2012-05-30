BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.AlbumView extends Backbone.View
  template: JST["backbone/templates/cards/album"]

  initialize: () ->
    @cards = @options.cards
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    @remove()
    $el = $(@el)
    $el.html(@template({}))
    $laminas = $el.find('.laminas')
    cards = @user.get('cards')
    for card, i  in @cards.models
      cardItemView = new BancoChile.Views.Cards.CardItemView(
        model: card, count: cards[i])
      $laminas.append(cardItemView.render().el)

    return this
