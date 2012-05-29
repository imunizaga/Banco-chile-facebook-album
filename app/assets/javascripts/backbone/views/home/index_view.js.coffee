BancoChile.Views.Home ||= {}

class BancoChile.Views.Home.IndexView extends Backbone.View
  template: JST["backbone/templates/home/index"]

  initialize: () ->
    @options.user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @options.user.toJSON() ))

    return this
