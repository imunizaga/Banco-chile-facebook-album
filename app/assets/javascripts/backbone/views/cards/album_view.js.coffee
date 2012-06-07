BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.AlbumView extends Backbone.View
  template: JST["backbone/templates/cards/album"]

  initialize: () ->
    @cards = @options.cards
    @user = @options.user

  render: =>
    # removes the DOM element
    @remove()
    $el = $(@el)

    #renders the main album template
    $el.html(@template(user: @user.toJSON(), cards: @cards.toJSON()))

    # obtains the 2 container div elements
    $laminas = $el.find('.laminas')
    $lightboxes = $el.find('.lightboxes')

    # render each card that will go in the album
    for card, i  in @cards.models
      # set the class for each element withing the container divs
      lightboxId = "light" + card.get('card_id')
      cardItemClassName = "card-item-" + card.get('card_id')

      # render the cardItemView
      cardItemView = new BancoChile.Views.Cards.CardItemView(
        model: card
        href: '#' + lightboxId
        className: cardItemClassName
      )
      $laminas.append(cardItemView.render().el)

      # render the lightboxView
      lightboxView = new BancoChile.Views.Cards.LightboxView(
        card: card
        user: @user
        lightboxId: lightboxId
      )
      $lightboxes.append(lightboxView.render().el)

      # set the cardItem to open the fancy box on click
      $(@el).find("." + cardItemClassName).fancybox()

    return this
