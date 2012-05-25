BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.EditView extends Backbone.View
  template : JST["backbone/templates/challenges/edit"]

  events :
    "submit #edit-challenge" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (challenge) =>
        @model = challenge
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
