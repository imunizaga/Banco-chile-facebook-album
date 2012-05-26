BancoChile.Views.CardPacks ||= {}

class BancoChile.Views.CardPacks.NewView extends Backbone.View
  template: JST["backbone/templates/card_packs/new"]

  events:
    "submit #new-card_pack": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (card_pack) =>
        @model = card_pack
        window.location.hash = "/#{@model.id}"

      error: (card_pack, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
