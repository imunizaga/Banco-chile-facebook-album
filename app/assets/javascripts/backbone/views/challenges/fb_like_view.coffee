BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookLikeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_like"]

  initialize: (@challenge) ->
    super()
    @binded = false

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON()))

    FB.XFBML.parse(document.getElementById('challenge-lightbox'))

    if not @binded
      @binded = true
      FB.Event.subscribe('edge.create', (response) =>
        @binded = false
        FB.Event.unsubscribe('edge.create', this)
        if response == @challenge.get('client_param')
          # notify the server the challenge is complete
          @completeChallenge()
      )

    return this
