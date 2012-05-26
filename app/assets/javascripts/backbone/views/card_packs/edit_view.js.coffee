BancoChile.Views.CardPacks ||= {}

class BancoChile.Views.CardPacks.EditView extends Backbone.View
  template : JST["backbone/templates/card_packs/edit"]

  events :
    "submit #edit-card_pack" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (card_pack) =>
        @model = card_pack
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
