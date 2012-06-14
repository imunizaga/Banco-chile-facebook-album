class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (@options) ->
    window.db =
      cards: new BancoChile.Collections.CardsCollection()
      users: new BancoChile.Collections.UsersCollection()

    window.db.cards.reset(@options.cards)
    window.db.users.reset(@options.user.friends)

    @user = new BancoChile.Models.User(@options.user)
    window.db.users.add(@user)

    @ranking = new BancoChile.Collections.UsersCollection(@options.ranking)
    @site_url = @options['SITE_URL']

    # Test data - remove!
    challenge_test_data = [
      title: 'Title1'
      description: 'Description1'
      action: 'Action1'
    ,
      title: 'Title2'
      description: 'Description2'
      action: 'Action2'
    ]

    @challenges = new BancoChile.Collections.ChallengesCollection(
      challenge_test_data)
    
    window.db.fetch = true

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
        challenges: @challenges
      )
      $container = $("#container")
      $container.html(@view.render().el)
