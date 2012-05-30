BancoChile.Views.Home ||= {}

class BancoChile.Views.Home.IndexView extends Backbone.View
  template: JST["backbone/templates/home/index"]
  loggedTemplate: JST["backbone/templates/home/logged"]
  notLoggedTemplate: JST["backbone/templates/home/not_logged"]

  initialize: () ->
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @user.toJSON()))

    loginStatus = @user.get('loginStatus')

    if loginStatus is 'connected'
      $(@.el).find('#mainContainer').append(@loggedTemplate(
        user: @user.toJSON()
      ))
      rankingView = new BancoChile.Views.Users.RankingView(user: @user)
      $(@.el).find('.ranking-list').append(rankingView.render().el)
    else if loginStatus
      $(@.el).find('#mainContainer').append(@notLoggedTemplate())

    return this
