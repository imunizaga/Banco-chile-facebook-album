BancoChile.Views.CardPacks ||= {}

class BancoChile.Views.CardPacks.CardPackView extends Backbone.View
  template: JST["backbone/templates/card_packs/card_pack"]

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
