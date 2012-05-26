BancoChile.Views.UserCards ||= {}

class BancoChile.Views.UserCards.EditView extends Backbone.View
  template : JST["backbone/templates/user_cards/edit"]

  events :
    "submit #edit-user_card" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (user_card) =>
        @model = user_card
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
