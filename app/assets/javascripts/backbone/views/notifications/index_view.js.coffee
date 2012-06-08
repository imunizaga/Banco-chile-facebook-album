BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.IndexView extends Backbone.View
  template: JST["backbone/templates/notifications/index"]

  initialize: () ->
    @options.notifications.bind('reset', @addAll)

  addAll: () =>
    @options.notifications.each(@addOne)

  addOne: (notification) =>
    view = new BancoChile.Views.Notifications.NotificationView({model : notification})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(notifications: @options.notifications.toJSON() ))
    @addAll()

    return this
