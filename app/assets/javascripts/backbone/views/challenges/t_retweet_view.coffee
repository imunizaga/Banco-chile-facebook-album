BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterRetweetView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/t_retweet"]
  renderAsButton: true

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    return this
