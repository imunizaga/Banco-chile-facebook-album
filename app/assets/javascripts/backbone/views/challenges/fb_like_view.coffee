BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookLikeView extends Backbone.View
  template: JST["backbone/templates/challenges/fb_like"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    FB.XFBML.parse(document.getElementById('challenge-lightbox'))
    FB.Event.subscribe('edge.create', (response) ->
      console.log("You liked #{response}, for challenge #{challenge.id}")
    )

    notification = new BancoChile.Models.Notification(
      challenge_id: challenge.id
    )

    notification.save({}
      success:=>
        toast(BancoChile.UIMessages.CHALLENGE_COMPLETED, 'user')
        @render()
    )
    return this
