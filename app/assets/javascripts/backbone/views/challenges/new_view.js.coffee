BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.NewView extends Backbone.View
  template: JST["backbone/templates/challenges/new"]

  events:
    "submit #new-challenge": "save"

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
      success: (challenge) =>
        @model = challenge
        window.location.hash = "/#{@model.id}"

      error: (challenge, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
