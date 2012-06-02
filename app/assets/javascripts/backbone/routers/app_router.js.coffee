class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @options = options
    @user = new BancoChile.Models.User(options.user)
    @user.get('cards').reset(options.cards)
    @ranking = new BancoChile.Collections.UsersCollection(options.ranking)

  routes:
    ""      : "index"
    "game"    : "game"
    "_=_"    : "goToIndex"

  goToIndex: ->
    @navigate('', trigger: true)

  index: ->
    @view = new BancoChile.Views.Home.IndexView(
      user: @user
      ranking: @ranking
    )
    $container = $("#container")
    $container.html(@view.render().el)

  game: ->
    if not @user.isAuthenticated()
      @navigate('', trigger: true)
    else
      @view = new BancoChile.Views.Game.IndexView(
        user: @user
        ranking: @ranking
      )
      $container = $("#container")
      $container.html(@view.render().el)
