BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookLikeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_like"]

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON()))

    FB.XFBML.parse(document.getElementById('challenge-lightbox'))

    FB.Event.subscribe('edge.create', (response) =>
      if response == @challenge.get('client_param')
        console.log("You liked #{response}, for challenge #{@challenge.get('id')}")
        # notify the server the challenge is complete
        @completeChallenge()
      FB.Event.unsubscribe('edge.create', this)
    )

    return this
