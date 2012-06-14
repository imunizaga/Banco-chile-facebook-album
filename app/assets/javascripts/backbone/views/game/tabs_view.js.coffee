BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.TabsView extends Backbone.View
  template: JST["backbone/templates/game/tabs"]

  initialize: () ->
    @user = @options.user
    @challenges = @options.challenges

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    
    for notification in @user.get('notifications').models
      notificationView = new BancoChile.Views.Notifications.NotificationView(
        'model': notification
      )
      $(@el).find('#tabs-1 ul').append(notificationView.render().el)

    for challenge in @challenges.models
      challengeView = new BancoChile.Views.Challenges.ChallengeView(
        'challenge': challenge
      )
      $(@el).find('#tabs-2 ul').append(challengeView.render().el)



    return this
