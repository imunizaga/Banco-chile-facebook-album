BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.RankingView extends Backbone.View
  template: JST["backbone/templates/users/ranking"]

  events:
    "click .js-prev": "backward"
    "click .js-next": "forward"

  initialize: () ->
    @ranking = @options.ranking
    @from = 1

  forward: () ->
    ### moves the ranking 8 places to the right as long as it can ###
    @from += 8

    # calculate the maximum value for "from"
    max_from = @ranking.models.length - 7

    if @from > max_from
      @from = max_from
      if @from < 1
        @from = 1
    @render()

  backward: () ->
    ### moves the ranking 8 places to the left as long as it can ###
    @from -= 8

    if @from < 1
      @from = 1
    @render()

  render: =>
    $el = $(@el)
    $el.html(@template({}))
    $ranking = $el.find('.ranking')

    count = 0
    for user in @ranking.models
      count++
      if count < @from
        continue
      if count > 8
        break
      rankingItem = new BancoChile.Views.Users.RankingItemView(
        user: user
        class: 'primero'
      )
      $ranking.append(rankingItem.render().el)

    return this
