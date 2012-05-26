class BancoChile.Routers.CardPacksRouter extends Backbone.Router
  initialize: (options) ->
    @cardPacks = new BancoChile.Collections.CardPacksCollection()
    @cardPacks.reset options.cardPacks

  routes:
    "new"      : "newCardPack"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCardPack: ->
    @view = new BancoChile.Views.CardPacks.NewView(collection: @cardPacks)
    $("#card_packs").html(@view.render().el)

  index: ->
    @view = new BancoChile.Views.CardPacks.IndexView(cardPacks: @cardPacks)
    $("#card_packs").html(@view.render().el)

  show: (id) ->
    card_pack = @cardPacks.get(id)

    @view = new BancoChile.Views.CardPacks.ShowView(model: card_pack)
    $("#card_packs").html(@view.render().el)

  edit: (id) ->
    card_pack = @cardPacks.get(id)

    @view = new BancoChile.Views.CardPacks.EditView(model: card_pack)
    $("#card_packs").html(@view.render().el)
