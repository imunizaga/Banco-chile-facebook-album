class BancoChile.Models.Card extends Backbone.Model
  paramRoot: 'card'

  defaults:
    info: null
    name: null
    set: null
    source: null
    count: 0

  initialize: (@options) ->
    if @options['id']
      @set('card_id', @options['id'])

  getImage: (size) ->
    image =  "https://graph.facebook.com/" + @get('source')
    return image + "/picture?type=" + size

  toJSON: () ->
    jsonCard = super()
    jsonCard.small_image = @getImage("square")
    jsonCard.normal_image = @getImage("normal")
    jsonCard.large_image = @getImage("large")
    return jsonCard

class BancoChile.Collections.CardsCollection extends Backbone.Collection
  model: BancoChile.Models.Card
  url: '/cards'

  filter: (card_id) ->
    return _.find(@models, (card)->
      return card.get('id') == card_id
    )

