BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterFollowView extends Backbone.View
  template: JST["backbone/templates/challenges/t_follow"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
