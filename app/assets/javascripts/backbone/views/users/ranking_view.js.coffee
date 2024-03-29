BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.RankingView extends Backbone.View
  template: JST["backbone/templates/users/ranking"]

  events:
    "click .js-prev": "backward"
    "click .js-next": "forward"

  initialize: () ->
    @ranking = @options.ranking
    @from = 1
    @ranking.bind('reset', @render, this)
    @offset = 0
    @fetching = false

  forward: () ->
    ### moves the ranking 8 places to the right as long as it can ###
    @from += 8

    # calculate the maximum value for "from"
    max_from = @ranking.models.length - 7

    if @from > max_from
      @from = max_from
      if @from < 1
        @from = 1

    if max_from > @ranking.models.length - 8
      if not @fetching
        @fetching = true
        newUsers = new BancoChile.Collections.UsersCollection()
        newUsers.fetch(
          data:
            offset: @ranking.models.length
          success: =>
            @ranking.add(newUsers.models)
            @fetching = false
            @render()
        )
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
    from = @from - 1
    to = @from + 7
    users = @ranking.models.slice(from, to)
    for user in users
      rankingItem = new BancoChile.Views.Users.RankingItemView(
        user: user
        class: 'primero'
      )
      $ranking.append(rankingItem.render().el)

    return this
