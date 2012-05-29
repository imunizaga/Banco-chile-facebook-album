BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.IndexView extends Backbone.View
  template: JST["backbone/templates/game/index"]

  initialize: () ->
    @options.user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @options.user.toJSON() ))

    return this
