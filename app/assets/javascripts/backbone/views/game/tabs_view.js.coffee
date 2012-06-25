BancoChile.Views.Game ||= {}

class BancoChile.Views.Game.TabsView extends Backbone.View
  ### The game view is where the user can see his notifications, (messages and
  trade requests), and the challenges he has to complete to get new cards,

  ###
  template: JST["backbone/templates/game/tabs"]

  initialize: () ->
    @user = @options.user
    # we take the list of challenges from our local db
    @challenges = window.db.challenges

  render: =>
    ### Renders the tabs view, which consists mainly in groups 2 views,
    The notifications views: A list of views that show messages and trade
      requests
    The challenges views: A list of views that show the challenges that a user
      can complete to get more cards

    ###
    $(@el).html(@template(user: @user.toJSON()))

    # list of notification views
    for notification in @user.get('notifications').models
      notificationView = new BancoChile.Views.Notifications.NotificationView(
        'model': notification
      )
      $(@el).find('#tabs-1 ul').append(notificationView.render().el)

    # list of challenge views
    for challenge in @challenges.models
      challengeView = new BancoChile.Views.Challenges.ChallengeItemView(
        'challenge': challenge
      )
      $(@el).find('#tabs-2 ul').append(challengeView.render().el)
      challengeView.bind('challengeActionClicked', @renderChallengeLightBox)

    return this

  renderChallengeLightBox: (challengeView)=>
    $('#challenge-lightbox').html(challengeView.el)
    challengeView.render()
