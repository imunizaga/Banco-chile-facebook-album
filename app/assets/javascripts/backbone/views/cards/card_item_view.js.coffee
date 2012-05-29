BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.CardItemView extends Backbone.View
  template: JST["backbone/templates/cards/item"]

  tagName: "li"

  initialize: () ->
    debugger
    @model = @options.model
    @model.bind('change', @render)

  render: ->
    debugger
    #<li class="laTengo">
    $(@el).html(@template(card: @model.toJSON() ))
    return this
