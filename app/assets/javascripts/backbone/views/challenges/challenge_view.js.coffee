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
        if window.app.user.tradeCards(notification.get('cards_in'), false)
          base_message = BancoChile.UIMessages.CHALLENGE_COMPLETED
          toast("#{base_message}: #{notification.get('cards_in')}", 'user')
          if not @renderAsButton
            $.fancybox.close()
        else
          toast(BancoChile.UIMessages.CHALLENGE_FAILED, 'user')
          window.location.reload()
      error:=>
        toast(BancoChile.UIMessages.CHALLENGE_FAILED, 'user')
        debugger
        window.location.reload()
    )
