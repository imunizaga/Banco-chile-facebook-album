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

    notifications = @user.get('notifications')
    notifications.bind('add', @renderNofications, this)
    notifications.bind('reset', @renderNofications, this)

  renderNofications: ->
    ### Renders the notifications of the user in the '#tabs-1 ul' element ###

    $tabs = $(@el).find('#tabs-1 ul')
    $tabs.empty()

    # list of notification views
    notifications = @user.get('notifications').models
    for notification in notifications
      notificationView = new BancoChile.Views.Notifications.NotificationView(
        'model': notification
      )
      $tabs.append(notificationView.render().el)

    # update the number of notifications
    $(@el).find('.js-notifications-length').html(notifications.length)

  render: =>
    ### Renders the tabs view, which consists mainly in groups 2 views,
    The notifications views: A list of views that show messages and trade
      requests
    The challenges views: A list of views that show the challenges that a user
      can complete to get more cards

    ###
    $(@el).html(@template(
      user: @user.toJSON()
      challenges: @challenges
    ))

    @renderNofications()

    twitter_connected = false
    if @user.get('twitter_connected')
      twitter_connected = true

    # list of challenge views
    for challenge in @challenges.models
      # if the user has completed the challenge
      if challenge.get('completed')
        # and the challenge is not repeatable
        if not challenge.get('repeatable')
          # render nothing
          continue

      challenge.set('twitter_connected', twitter_connected)

      if challenge.get('kind') == 'invite'
        challengeView = new BancoChile.Views.Challenges.FacebookInviteView(
          'challenge': challenge
        )
      else
        challengeView = new BancoChile.Views.Challenges.ChallengeItemView(
          'challenge': challenge
        )
      if challenge.get('kind') == 'share'
        $(@el).find('#tabs-2 ul').prepend(challengeView.render().el)
      if challenge.get('kind') == 'invite'
        $(@el).find('#tabs-2').prepend(challengeView.render().el)
      else
        $(@el).find('#tabs-2 ul').append(challengeView.render().el)
      challengeView.bind('challengeActionClicked', @renderChallengeLightBox)

    return this

  renderChallengeLightBox: (challengeView)=>
    $('#challenge-lightbox').html(challengeView.el)
    challengeView.render()
