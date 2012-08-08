class BancoChile.Routers.AppRouter extends Backbone.Router
  initialize: (@options) ->
    ### The router is what we use to handle urls within our backbone app.
    Since it's central to the application, it's instance will be stored
    in window.app, and contains the main collections to render the page

    Note:
     To avoid calling the server many times, we will the window.db
     object to handle data data should not change
     Cards and challenges are static information, users may change
     but it should be understood, that one should only take data from
     window.db that it's improbable to change, like de facebook_id
    ###
    window.db =
      cards: new BancoChile.Collections.CardsCollection()
      users: new BancoChile.Collections.UsersCollection()
      challenges: new BancoChile.Collections.ChallengesCollection()

    window.db.cards.reset(@options.cards)
    window.db.users.reset(@options.user.friends)
    window.db.challenges.reset(@options.challenges)

    # the user that's logged in the app
    @user = new BancoChile.Models.User(@options.user)

    # add the user to our database
    window.db.users.add(@user)

    # the ranking of the page
    @ranking = new BancoChile.Collections.UsersCollection(@options.ranking)

    # the base url used
    @site_url = "#{window.location.protocol}//#{window.location.host}"

    if @options.userChallenges
      for userChallenge in @options.userChallenges
        challenge = window.db.challenges.get(userChallenge.challenge_id)
        if challenge
          challenge.set('completed', true)

    # bind google's page view tracking
    @bind 'all', @_trackPageview

    return this

  routes:
    ""      : "index"
    "game"    : "game"
    "games/:id"    : "games"
    "_=_"    : "goToIndex"

  goToIndex: ->
    # facebook somethimes returns to the url with the hash _=_
    # We simply re-route to the home in that case
    @navigate('', trigger: true)

  index: ->
    ### go to the index view ###
    @view = new BancoChile.Views.Home.IndexView(
      user: @user
      ranking: @ranking
    )
    $container = $("#container")
    $container.html(@view.el)
    @view.render()

  game: ->
    ### renthers the game view ###
    #
    window.scrollTo(0,0)

    # if the user is not authenticated
    if not @user.isAuthenticated()
      # go to the index view
      @navigate('', trigger: true)
    else
      # render the game view
      @view = new BancoChile.Views.Game.IndexView(
        user: @user
        ranking: @ranking
      )
      $container = $("#container")
      $container.html(@view.el)
      @view.render()
      
  # google's page view tracking
  _trackPageview: ->
    _gaq.push(['_trackPageview', "/#{Backbone.history.getFragment()}"]) if typeof _gaq isnt 'undefined'

