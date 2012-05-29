BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.CardItemView extends Backbone.View
  template: JST["backbone/templates/cards/item"]

  tagName: "li"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
