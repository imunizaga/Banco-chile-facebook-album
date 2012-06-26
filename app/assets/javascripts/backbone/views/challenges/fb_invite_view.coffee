BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookInviteView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_invite"]

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    return this
