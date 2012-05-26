BancoChile.Views.UserCards ||= {}

class BancoChile.Views.UserCards.UserCardView extends Backbone.View
  template: JST["backbone/templates/user_cards/user_card"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
