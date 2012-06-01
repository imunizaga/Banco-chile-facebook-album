class BancoChile.Views.Users.RankingView extends Backbone.View
  template: JST["backbone/templates/users/ranking"]

  initialize: () ->
    @ranking = @options.ranking
    @options.user.bind('change', @render)

  render: =>
    $el = $(@el)
    $el.html(@template({}))
    $ranking = $el.find('.ranking')
    for user in @ranking.models
      rankingItem = new BancoChile.Views.Users.RankingItemView(
        user: user
        class: 'primero'
      )
      $ranking.append(rankingItem.render().el)

    return this
