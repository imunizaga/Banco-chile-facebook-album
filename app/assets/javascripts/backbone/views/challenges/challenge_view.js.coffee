BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  template: JST["backbone/templates/challenges/challenge"]
  tagName: "li"

  initialize: () ->
    @challenge = @options.challenge

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    $(@el).find(".accion").fancybox()
    return this
