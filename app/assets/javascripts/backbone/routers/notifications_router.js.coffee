class BancoChile.Routers.NotificationsRouter extends Backbone.Router
  initialize: (options) ->
    @notifications = new BancoChile.Collections.NotificationsCollection()
    @notifications.reset options.notifications

  routes:
    "new"      : "newNotification"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newNotification: ->
    @view = new BancoChile.Views.Notifications.NewView(collection: @notifications)
    $("#notifications").html(@view.render().el)

  index: ->
    @view = new BancoChile.Views.Notifications.IndexView(notifications: @notifications)
    $("#notifications").html(@view.render().el)

  show: (id) ->
    notification = @notifications.get(id)

    @view = new BancoChile.Views.Notifications.ShowView(model: notification)
    $("#notifications").html(@view.render().el)

  edit: (id) ->
    notification = @notifications.get(id)

    @view = new BancoChile.Views.Notifications.EditView(model: notification)
    $("#notifications").html(@view.render().el)
