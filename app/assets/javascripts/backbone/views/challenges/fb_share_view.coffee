BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookShareView extends Backbone.View
  template: JST["backbone/templates/challenges/fb_share"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
