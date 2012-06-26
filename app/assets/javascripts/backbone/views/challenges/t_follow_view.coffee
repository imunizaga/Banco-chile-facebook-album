BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterFollowView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/t_follow"]
  renderAsButton: true

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    return this
