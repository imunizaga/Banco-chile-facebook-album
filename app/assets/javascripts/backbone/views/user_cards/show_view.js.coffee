BancoChile.Views.UserCards ||= {}

class BancoChile.Views.UserCards.ShowView extends Backbone.View
  template: JST["backbone/templates/user_cards/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
