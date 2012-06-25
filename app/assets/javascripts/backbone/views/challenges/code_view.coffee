BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.CodeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/code"]

  events:
    "click .js-send-code": "completeChallenge"

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON()))

    return this
