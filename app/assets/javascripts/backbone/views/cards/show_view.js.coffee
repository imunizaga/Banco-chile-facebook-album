BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.ShowView extends Backbone.View
  template: JST["backbone/templates/cards/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
