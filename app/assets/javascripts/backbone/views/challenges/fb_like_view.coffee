BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookLikeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_like"]

  initialize: (@challenge) ->
    super(@challenge)
    @binded = false

  render: =>
    $(@el).html(@template(challenge: @challenge.toJSON()))

    FB.XFBML.parse(document.getElementById('challenge-lightbox'))

    console.log("going to bind, binded: #{@binded}")
    if not @binded
      @binded = true
      FB.Event.subscribe('edge.create', (response) =>
        console.log("like clicked!")
        console.log(response)
        console.log(@challenge.toJSON())
        if response == @challenge.get('client_param')
          # unsubscribe from the like event
          FB.Event.unsubscribe('edge.create', this)
          @binded = false
          # notify the server the challenge is complete
          @completeChallenge()
      )

    return this
