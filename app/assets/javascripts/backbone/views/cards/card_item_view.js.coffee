BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.CardItemView extends Backbone.View
  template: JST["backbone/templates/cards/item"]

  tagName: "li"

  initialize: () ->
    @model = @options.model
    @model.bind('change', @render)

  render: ->
    $(@el).html(@template(card: @model.toJSON(), count: @options.count or 0))
    return this
