class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @user = new BancoChile.Models.User(options.user)
    @cards = new BancoChile.Collections.CardsCollection(options.cards)

  routes:
    ""      : "index"
    "game"    : "game"

  index: ->
    @view = new BancoChile.Views.Home.IndexView(user: @user)
    $container = $("#container")
    $container.html(@view.render().el)

  game: ->
    @view = new BancoChile.Views.Game.IndexView(user: @user, cards: @cards)
    $container = $("#container")
    $container.html(@view.render().el)
