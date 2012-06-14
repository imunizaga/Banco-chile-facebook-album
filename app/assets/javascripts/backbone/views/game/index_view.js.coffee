BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.IndexView extends Backbone.View
  template: JST["backbone/templates/game/index"]

  initialize: () ->
    @user = @options.user
    @cards = @user.get('cards')
    @ranking = @options.ranking
    @challenges = @options.challenges
    @user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @user.toJSON() ))

    albumView = new BancoChile.Views.Cards.AlbumView(user: @user, cards: @cards)
    $(@.el).find('.album').append(albumView.render().el)

    rankingView = new BancoChile.Views.Users.RankingView(
      user: @user
      ranking: @ranking
    )
    $(@.el).find('.ranking-list').append(rankingView.render().el)

    tabsView = new BancoChile.Views.Game.TabsView(
      user: @user,
      challenges: @challenges
    )
    $tabs = $(@.el).find('#tabs')

    $tabs.append(tabsView.render().el)
    $tabs.tabs(event: "click")

    return this
