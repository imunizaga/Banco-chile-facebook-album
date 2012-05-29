BancoChile.Views.Home ||= {}

class BancoChile.Views.Home.IndexView extends Backbone.View
  template: JST["backbone/templates/home/index"]

  initialize: () ->
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @user.toJSON() ))

    rankingView = new BancoChile.Views.Users.RankingView(user: @user)
    $(@.el).find('.ranking-list').append(rankingView.render().el)

    return this
