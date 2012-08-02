BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  renderAsButton: false

  initialize: (@challenge) ->
    super()

  completeChallenge: (data)->
    notification = new BancoChile.Models.Notification(
      challenge_id: @challenge.get('id')
      data: data
    )

    notification.save({}
      success:=>
        # since we need to parse the reason, then we need the notification
        # contain the success response
        if notification.get('success') == false
          type = notification.get('reason')
          reason = BancoChile.UIMessages.CHALLENGE_FAILED[type]
          toast(reason, 'user')
        else
          @challenge.set('completed', true)
          user = window.app.user
          if user.tradeCards(notification.get('cards_in'), false)
            base_message = BancoChile.UIMessages.CHALLENGE_COMPLETED
            if not @renderAsButton
              $.fancybox.close()
            toast("#{base_message}: #{JSON.parse(notification.get('cards_in'))[0]}", 'user')
            user.get('notifications').add(notification, {at: 0})
          else
            toast(BancoChile.UIMessages.CHALLENGE_FAILED['default'], 'user')
      error: (response, asdf)=>
        toast(BancoChile.UIMessages.CHALLENGE_FAILED['default'], 'user')
    )
