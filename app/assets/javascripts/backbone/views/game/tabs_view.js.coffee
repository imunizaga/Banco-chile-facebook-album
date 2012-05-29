BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.TabsView extends Backbone.View
  template: JST["backbone/templates/game/tabs"]

  initialize: () ->
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @user.toJSON() ))

    return this
