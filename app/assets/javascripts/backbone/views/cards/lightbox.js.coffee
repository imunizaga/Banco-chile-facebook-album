BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxView extends Backbone.View
  template: JST["backbone/templates/cards/lightbox"]

  className: "hidden"

  initialize: () ->
    @card = @options.card
    @lightboxId = @options.lightboxId

  render: ->
    $(@el).html(@template(card: @card.toJSON()))
    $(@el).find('.lightbox-container').attr('id', @lightboxId)
    return this
