BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxView extends Backbone.View
  template: JST["backbone/templates/cards/lightbox"]

  className: "hidden"

  initialize: () ->
    @card = @options.card
    @lightboxId = @options.lightboxId

  render: ->
    $(@el).html(@template(card: @card.toJSON()))
    $(@el).find('.js-lightbox-container').attr('id', @lightboxId)
    if @card.get('count') == 0
      contentTemplate = JST["backbone/templates/cards/lightbox-got-none"]
    else if @card.get('count') == 1
      contentTemplate = JST["backbone/templates/cards/lightbox-got-one"]
    else
      contentTemplate = JST["backbone/templates/cards/lightbox-got-many"]
    $(@el).find('.js-lightbox-container').append(contentTemplate({}))
    return this
