BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookShareView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_share"]

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    return this
