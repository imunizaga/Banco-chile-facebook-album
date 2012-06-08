BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.EditView extends Backbone.View
  template : JST["backbone/templates/notifications/edit"]

  events :
    "submit #edit-notification" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (notification) =>
        @model = notification
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
