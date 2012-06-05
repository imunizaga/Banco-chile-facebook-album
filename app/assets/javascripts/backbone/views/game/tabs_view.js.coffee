BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.TabsView extends Backbone.View
  template: JST["backbone/templates/game/tabs"]

  initialize: () ->
    @user = @options.user
    @notifications = @options.notifications
    @user.bind('change', @render)

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    
    for notification in @notifications
      notificationView = new BancoChile.Views.Notifications.NotificationView(
        'notification': notification
      )
      $(@el).find('#tabs-1').append(notificationView.render().el)

    return this
