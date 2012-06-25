BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookInviteView extends Backbone.View
  template: JST["backbone/templates/challenges/fb_invite"]

  initialize: (@challenge) ->
    super()

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
