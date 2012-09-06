BancoChile.Views.Home ||= {}

class BancoChile.Views.Home.IndexView extends Backbone.View
  ### The index view is where the user can see the prizes, mainly used as
  a presentation for the game view

   There are 2 templates appart from the main one, (logged, and not_logged).
  The idea was to separate logic from templates, so we decided to create two
  templates for the bottom of the page

  ###
  template: JST["backbone/templates/home/index"]
  endedTemplate: JST["backbone/templates/home/ended"]
  loggedTemplate: JST["backbone/templates/home/logged"]
  notLoggedTemplate: JST["backbone/templates/home/not_logged"]

  initialize: () ->
    @user = @options.user
    @ranking = @options.ranking
    @user.bind('change', @render)

  render: =>
    ### Renders the index view, which consists mainly in the main template
    and a bottom div that holds one of two templates:
    logged: A template to render the state of the index when logged in
    not_logged: A template to render the state of the index when logged out

    ###
    $(@el).html(@template(user: @user.toJSON()))

    loginStatus = @user.get('login_status')

    # login status is the status that facebook responded
    if loginStatus is 'connected'
      #check if the app is closed
      if app.closed
        if @user.get('unique_cards_count') == 50
          banner = "bannerFinalCompleto.jpg"
        else
          banner = "bannerFinalMedio.jpg"
        $(@el).html(@endedTemplate(banner: banner))
      else
        # if we reach this point, the user is connected and the app is not
        # closed
        $(@el).find('#mainContainer').append(@loggedTemplate(
          user: @user.toJSON()
        ))
        rankingView = new BancoChile.Views.Users.RankingView(
          user: @user
          ranking: @ranking
        )
        $(@el).find('.ranking-list').append(rankingView.render().el)
    else if loginStatus
      # if we reach this point, loginStatus is not defined, and that means that
      # facebook has responded that the user is not logged
      $(@el).find('#mainContainer').append(@notLoggedTemplate())

    gameDataTemplate = JST["backbone/templates/home/game_data"]
    $(@el).find('.game-data').html(gameDataTemplate())

    $(@el).find(".como").fancybox()

    return this
