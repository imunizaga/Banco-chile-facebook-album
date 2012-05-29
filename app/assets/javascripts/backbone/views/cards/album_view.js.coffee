BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.AlbumView extends Backbone.View
  template: JST["backbone/templates/cards/album"]

  initialize: () ->
    @cards = @options.cards
    @cards.bind('reset', @render)

  render: =>
    $(@el).html(@template(cards: @cards.toJSON() ))

    return this
