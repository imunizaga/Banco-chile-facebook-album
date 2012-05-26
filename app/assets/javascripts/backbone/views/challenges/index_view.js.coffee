BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.IndexView extends Backbone.View
  template: JST["backbone/templates/challenges/index"]

  initialize: () ->
    @options.challenges.bind('reset', @addAll)

  addAll: () =>
    @options.challenges.each(@addOne)

  addOne: (challenge) =>
    view = new BancoChile.Views.Challenges.ChallengeView({model : challenge})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(challenges: @options.challenges.toJSON() ))
    @addAll()

    return this
