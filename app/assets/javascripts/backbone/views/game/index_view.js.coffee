BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.IndexView extends Backbone.View
  ### The game view is where the user can see his album, the tabs with actions,
  and the ranking

  ###
  template: JST["backbone/templates/game/index"]

  initialize: () ->
    ### Set the user whoose album we are going to show and the ranking we 
    want to display at the bottom

    ###
    @user = @options.user
    @ranking = @options.ranking

    @user.bind('change', @render)

  render: =>
    ### Renders the game view, which consists mainly in 3 views, 
    The album view: where the user can see his cards
    The tabs view: Where the user can see challenges and notifications
    The ranking view: Where the user can see whoose wining the contest

    ###
    $(@el).html(@template(user: @user.toJSON() ))

    #album view
    albumView = new BancoChile.Views.Cards.AlbumView(user: @user)
    $(@.el).find('.album').append(albumView.render().el)

    # Ranking view
    rankingView = new BancoChile.Views.Users.RankingView(
      user: @user
      ranking: @ranking
    )
    $(@.el).find('.ranking-list').append(rankingView.render().el)

    # Tabs view
    tabsView = new BancoChile.Views.Game.TabsView(
      user: @user,
    )

    ## initialize the tabs view
    $tabs = $(@el).find('#tabs')
    $tabs.append(tabsView.el)
    tabsView.render()
    $tabs.tabs(event: "click")
    twttr.anywhere.config(
      callbackURL: window.app.site_url + "/auth/twitter/callback"
    )
    twttr.anywhere((T) ->
      T("#login-twitter").connectButton()
    )

    return this
