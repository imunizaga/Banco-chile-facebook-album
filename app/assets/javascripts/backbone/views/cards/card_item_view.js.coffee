BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.CardItemView extends Backbone.View
  template: JST["backbone/templates/cards/item"]

  events:
    "click": "clicked"

  tagName: "li"

  initialize: () ->
    @model = @options.model
    @href = @options.href

  render: ->
    $(@el).html(@template(card: @model.toJSON()))
    $(@el).attr('href', @href)

    return this

  clicked: ->
    @trigger('cardItemClicked')
