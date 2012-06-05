BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.NotificationView extends Backbone.View
  template: JST["backbone/templates/notifications/notification"]
  tagName: "li"

  initialize: () ->
    @notification = @options.notification

  render: =>
    $(@el).html(@template(notification: @notification.toJSON() ))
    return this
