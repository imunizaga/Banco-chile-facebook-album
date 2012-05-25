BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.NewView extends Backbone.View
  template: JST["backbone/templates/cards/new"]

  events:
    "submit #new-card": "save"

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
      success: (card) =>
        @model = card
        window.location.hash = "/#{@model.id}"

      error: (card, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
