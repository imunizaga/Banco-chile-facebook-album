BancoChile.Views.CardPacks ||= {}

class BancoChile.Views.CardPacks.IndexView extends Backbone.View
  template: JST["backbone/templates/card_packs/index"]

  initialize: () ->
    @options.cardPacks.bind('reset', @addAll)

  addAll: () =>
    @options.cardPacks.each(@addOne)

  addOne: (cardPack) =>
    view = new BancoChile.Views.CardPacks.CardPackView({model : cardPack})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(cardPacks: @options.cardPacks.toJSON() ))
    @addAll()

    return this
