BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  template: JST["backbone/templates/challenges/challenge"]
  tagName: "li"

  initialize: () ->
    @user = @options.user

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
