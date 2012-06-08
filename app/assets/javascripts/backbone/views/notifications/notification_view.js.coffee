BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.NotificationView extends Backbone.View
  template: JST["backbone/templates/notifications/notification"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
