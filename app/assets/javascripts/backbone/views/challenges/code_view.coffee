BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.CodeView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/code"]

  events:
    "click .js-send-code": "completeChallenge"

  completeChallenge: ->
    data = $(@el).find(".js-code-input").val()
    super(data)

  render: ->
    if not @rendered
      $(@el).html(@template(challenge: @challenge.toJSON()))
      @rendered = true
    @delegateEvents()

    return this
