BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  renderAsButton: false

  initialize: (@challenge) ->
    super()

  completeChallenge: ->
    notification = new BancoChile.Models.Notification(
      challenge_id: @challenge.get('id')
    )

    notification.save({}
      success:=>
        user = window.app.user
        if user.tradeCards(notification.get('cards_in'), false)
          base_message = BancoChile.UIMessages.CHALLENGE_COMPLETED
          if not @renderAsButton
            $.fancybox.close()
          toast("#{base_message}: #{notification.get('cards_in')}", 'user')
          user.get('notifications').push(notification)
        else
          toast(BancoChile.UIMessages.CHALLENGE_FAILED, 'user')
      error:=>
        toast(BancoChile.UIMessages.CHALLENGE_FAILED, 'user')
    )
