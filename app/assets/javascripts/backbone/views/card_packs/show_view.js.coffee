BancoChile.Views.CardPacks ||= {}

class BancoChile.Views.CardPacks.ShowView extends Backbone.View
  template: JST["backbone/templates/card_packs/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
