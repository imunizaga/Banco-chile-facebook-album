BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.CodeView extends Backbone.View
  template: JST["backbone/templates/challenges/code"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
