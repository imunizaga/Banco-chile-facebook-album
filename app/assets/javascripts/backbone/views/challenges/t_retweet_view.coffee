BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterRetweetView extends Backbone.View
  template: JST["backbone/templates/challenges/t_retweet"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
