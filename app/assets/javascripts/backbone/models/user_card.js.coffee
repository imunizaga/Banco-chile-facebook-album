class BancoChile.Models.UserCard extends Backbone.Model
  paramRoot: 'user_card'

  defaults:
    user_id: null
    card_id: null

class BancoChile.Collections.UserCardsCollection extends Backbone.Collection
  model: BancoChile.Models.UserCard
  url: '/user_cards'
