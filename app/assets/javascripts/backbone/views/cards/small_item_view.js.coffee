BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.SmallCardItemView extends Backbone.View
  template: JST["backbone/templates/cards/small_item"]

  tagName: "li"

  events:
    "click": "clicked"

  initialize: () ->
    @model = @options.model

  render: ->
    $(@el).html(@template(card: @model.toJSON()))

    return this

  clicked: () ->
    console.log('small Card Item Clicked')
    @trigger('smallCardItemViewClicked', @model)
