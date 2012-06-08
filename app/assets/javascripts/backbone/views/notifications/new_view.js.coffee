BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.NewView extends Backbone.View
  template: JST["backbone/templates/notifications/new"]

  events:
    "submit #new-notification": "save"

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
      success: (notification) =>
        @model = notification
        window.location.hash = "/#{@model.id}"

      error: (notification, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
