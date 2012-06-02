BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.AlbumView extends Backbone.View
  template: JST["backbone/templates/cards/album"]

  initialize: () ->
    @cards = @options.cards
    @user = @options.user
    @user.bind('change', @render)

  render: =>
    # removes the DOM element
    @remove()
    $el = $(@el)

    #renders the main album template
    $el.html(@template(user: @user.toJSON(), cards: @cards.toJSON()))

    # obtains the 'laminas' div object
    $laminas = $el.find('.laminas')

    # render each card that will go in the album
    for card, i  in @cards.models
      cardItemView = new BancoChile.Views.Cards.CardItemView(model: card)
      $laminas.append(cardItemView.render().el)

    return this
