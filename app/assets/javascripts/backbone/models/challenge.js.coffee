class BancoChile.Models.Challenge extends Backbone.Model
  paramRoot: 'challenge'

  defaults:
    action: null
    description: null
    n_cards: null
    name: null
    set: null
    title: null

class BancoChile.Collections.ChallengesCollection extends Backbone.Collection
  model: BancoChile.Models.Challenge
  url: '/challenges'
