class BancoChile.Models.Card extends Backbone.Model
  paramRoot: 'card'

  defaults:
    info: null
    name: null
    set: null
    source: null

class BancoChile.Collections.CardsCollection extends Backbone.Collection
  model: BancoChile.Models.Card
  url: '/cards'
