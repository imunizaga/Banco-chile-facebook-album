BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ShowView extends Backbone.View
  template: JST["backbone/templates/challenges/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
