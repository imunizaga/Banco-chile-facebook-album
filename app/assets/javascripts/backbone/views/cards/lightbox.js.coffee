BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxView extends Backbone.View
  template: JST["backbone/templates/cards/lightbox"]

  className: "hidden"

  initialize: () ->
    @card = @options.card
    @user = @options.user
    @lightboxId = @options.lightboxId

  render: ->
    $(@el).html(@template(card: @card.toJSON()))
    $(@el).find('.js-lightbox-container').attr('id', @lightboxId)

    params =
      card: @card
      user: @user

    if @card.get('count') == 0
      contentView = new BancoChile.Views.Cards.LightboxGotNoneView(params)
    else if @card.get('count') == 1
      contentView = new BancoChile.Views.Cards.LightboxGotOneView(params)
    else
      contentView = new BancoChile.Views.Cards.LightboxGotManyView(params)

    $(@el).find('.js-lightbox-container').append(contentView.render().el)

    return this
