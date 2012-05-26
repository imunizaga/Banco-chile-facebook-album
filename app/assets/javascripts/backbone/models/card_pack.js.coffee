class BancoChile.Models.CardPack extends Backbone.Model
  paramRoot: 'card_pack'

  defaults:
    challenge_id: null

class BancoChile.Collections.CardPacksCollection extends Backbone.Collection
  model: BancoChile.Models.CardPack
  url: '/card_packs'
