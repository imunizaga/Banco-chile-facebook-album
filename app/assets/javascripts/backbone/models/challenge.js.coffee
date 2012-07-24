class BancoChile.Models.Challenge extends Backbone.Model
  paramRoot: 'challenge'

  initialize: (@options) ->
    @set('title', BancoChile.UIMessages.CHALLENGE_TITLES[@options['kind']])
    description = BancoChile.UIMessages.CHALLENGE_DESCRIPTIONS[@options['kind']]
    @set('description', description + @get('description'))
    debugger
    @set('action', BancoChile.UIMessages.CHALLENGE_ACTIONS[@options['kind']])

  defaults:
    action: null
    description: null
    n_cards: null
    name: null
    set: null
    title: null
    href: "#challenge-lightbox"

class BancoChile.Collections.ChallengesCollection extends Backbone.Collection
  model: BancoChile.Models.Challenge
  url: '/challenges'
