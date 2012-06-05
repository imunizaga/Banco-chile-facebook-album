BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.SmallRankingView extends Backbone.View
  template: JST["backbone/templates/users/small_ranking"]

  initialize: () ->
    @ranking = @options.ranking
    @options.user.bind('change', @render)

  render: =>
    $el = $(@el)
    $el.html(@template({}))
    $ranking = $el.find('.ranking')
    for user in @ranking.models
      rankingItem = new BancoChile.Views.Users.SmallRankingItemView(
        user: user
        class: 'primero'
      )
      $ranking.append(rankingItem.render().el)

    return this
