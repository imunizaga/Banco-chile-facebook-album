BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookShareView extends BancoChile.Views.Challenges.ChallengeView
  renderAsButton: true

  template: JST["backbone/templates/challenges/fb_share"]

  events:
    "click .js-share-btn": "shareBtnClicked"

  shareBtnClicked: ->
    callback = (response) =>
      @completeChallenge(response.post_id)

    FB.ui(JSON.parse(@challenge.get('client_param')), callback)

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    @delegateEvents()
    return this
