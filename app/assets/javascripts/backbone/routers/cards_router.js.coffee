class BancoChile.Routers.CardsRouter extends Backbone.Router
  initialize: (options) ->
    @cards = new BancoChile.Collections.CardsCollection()
    @cards.reset options.cards

  routes:
    "new"      : "newCard"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCard: ->
    @view = new BancoChile.Views.Cards.NewView(collection: @cards)
    $("#cards").html(@view.render().el)

  index: ->
    @view = new BancoChile.Views.Cards.IndexView(cards: @cards)
    $("#cards").html(@view.render().el)

  show: (id) ->
    card = @cards.get(id)

    @view = new BancoChile.Views.Cards.ShowView(model: card)
    $("#cards").html(@view.render().el)

  edit: (id) ->
    card = @cards.get(id)

    @view = new BancoChile.Views.Cards.EditView(model: card)
    $("#cards").html(@view.render().el)
