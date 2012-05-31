class BancoChile.Views.Users.RankingView extends Backbone.View
  template: JST["backbone/templates/users/ranking"]

  initialize: () ->
    @ranking = @options.ranking
    @options.user.bind('change', @render)

  render: =>
    $el = $(@el)
    $el.html(@template({}))
    $ranking = $el.find('.ranking')
    for user in @ranking
      user.img = user.img or "/assets/faceUser.jpg"
      user.class = user.class or ""
      user.n_cards = user.n_cards or 0

      rankingItem = new BancoChile.Views.Users.RankingItemView('user': user)
      $ranking.append(rankingItem.render().el)

    return this
