class BancoChile.Views.Users.RankingView extends Backbone.View
  template: JST["backbone/templates/users/ranking"]

  initialize: () ->
    @options.user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @options.user.toJSON() ))

    return this
