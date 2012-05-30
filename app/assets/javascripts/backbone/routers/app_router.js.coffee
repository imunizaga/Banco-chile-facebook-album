class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @user = new BancoChile.Models.User(options.user)
    @cards = new BancoChile.Collections.CardsCollection(options.cards)
    options.user_cards ||= new Array(options.cards.length)
    @user.set('cards', options.user_cards)

  routes:
    ""      : "index"
    "game"    : "game"

  index: ->
    @view = new BancoChile.Views.Home.IndexView(user: @user)
    $container = $("#container")
    $container.html(@view.render().el)

  game: ->
    if not @user.is_authenticated()
      @navigate('', trigger: true)
    else
      @view = new BancoChile.Views.Game.IndexView(user: @user, cards: @cards)
      $container = $("#container")
      $container.html(@view.render().el)
