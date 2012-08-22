BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookLikeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_like"]

  initialize: (@challenge) ->
    super(@challenge)
    @binded = false

  events:
    "click .js-fb-like-button": "likeButtonClicked"

  likeButtonClicked: =>
    @completeChallenge()

  render: =>
    # check if the challenge is completed when opening the like box
    #@completeChallenge()

    $(@el).html(@template(challenge: @challenge.toJSON()))

    FB.XFBML.parse(document.getElementById('challenge-lightbox'))

    if not @binded
      @binded = true
      FB.Event.subscribe('edge.create', (response) =>
        # unsubscribe from the like event
        FB.Event.unsubscribe('edge.create', this)
        @binded = false
        # notify the server the challenge is complete
        @completeChallenge()
      )

      FB.Event.subscribe('edge.remove', (response) =>
        # unsubscribe from the like event
        FB.Event.unsubscribe('edge.remove', this)
        @binded = false
        # notify the server the challenge is complete
        @completeChallenge()
      )

    return this
