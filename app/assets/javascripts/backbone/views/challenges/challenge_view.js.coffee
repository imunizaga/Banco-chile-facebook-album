BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  initialize: (@challenge) ->
    super()

  completeChallenge: ->
    notification = new BancoChile.Models.Notification(
      challenge_id: @challenge.get('id')
    )

    notification.save({}
      success:=>
        toast(BancoChile.UIMessages.CHALLENGE_COMPLETED, 'user')
        @render()
    )
