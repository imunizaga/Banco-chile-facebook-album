BancoChile.Views.UserCards ||= {}

class BancoChile.Views.UserCards.NewView extends Backbone.View
  template: JST["backbone/templates/user_cards/new"]

  events:
    "submit #new-user_card": "save"

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
      success: (user_card) =>
        @model = user_card
        window.location.hash = "/#{@model.id}"

      error: (user_card, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
