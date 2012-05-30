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
    debugger
    $el.html(@template(user: @user.toJSON(), cards: @cards.toJSON()))

    # obtains the 'laminas' div object
    $laminas = $el.find('.laminas')

    # obtains the count of the cards that the user has
    cardsCount = @user.get('cardsCount')

    # render each card that will go in the album
    for card, i  in @cards.models
      cardItemView = new BancoChile.Views.Cards.CardItemView(
        model: card, count: cardsCount[i])
      $laminas.append(cardItemView.render().el)

    return this
