class BancoChile.Routers.UserCardsRouter extends Backbone.Router
  initialize: (options) ->
    @userCards = new BancoChile.Collections.UserCardsCollection()
    @userCards.reset options.userCards

  routes:
    "new"      : "newUserCard"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newUserCard: ->
    @view = new BancoChile.Views.UserCards.NewView(collection: @userCards)
    $("#user_cards").html(@view.render().el)

  index: ->
    @view = new BancoChile.Views.UserCards.IndexView(userCards: @userCards)
    $("#user_cards").html(@view.render().el)

  show: (id) ->
    user_card = @userCards.get(id)

    @view = new BancoChile.Views.UserCards.ShowView(model: user_card)
    $("#user_cards").html(@view.render().el)

  edit: (id) ->
    user_card = @userCards.get(id)

    @view = new BancoChile.Views.UserCards.EditView(model: user_card)
    $("#user_cards").html(@view.render().el)
