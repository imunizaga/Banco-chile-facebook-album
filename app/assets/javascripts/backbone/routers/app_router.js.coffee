class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @options = options
    @user = new BancoChile.Models.User(options.user)
    @user.get('cards').reset(options.cards)
    @ranking = new BancoChile.Collections.UsersCollection(options.ranking)

    # Test data - remove!
    @notifications = [
      description: 'Juan te ha propuesto un cambio de láminas'
      details: 'Lámina 15 por lámina 5'
      title: 'Cambio de láminas'
    ,
      description: 'Ganaste una lámina por retweet'
      details: 'Ahora es tuya la lámina 2'
      title: 'Ganaste una lámina'
    ]

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
        notifications: @notifications
      )
      $container = $("#container")
      $container.html(@view.render().el)
