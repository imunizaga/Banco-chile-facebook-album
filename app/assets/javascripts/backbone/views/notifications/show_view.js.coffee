BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.ShowView extends Backbone.View
  template: JST["backbone/templates/notifications/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
