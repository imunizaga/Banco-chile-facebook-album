class BancoChile.Models.Challenge extends Backbone.Model
  paramRoot: 'challenge'

  defaults:
    description: null
    n_cards: null
    name: null
    type: null

class BancoChile.Collections.ChallengesCollection extends Backbone.Collection
  model: BancoChile.Models.Challenge
  url: '/challenges'
