BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.CardView extends Backbone.View
  template: JST["backbone/templates/cards/card"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
