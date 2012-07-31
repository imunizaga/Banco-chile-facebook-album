class BancoChile.Models.Challenge extends Backbone.Model
  paramRoot: 'challenge'

  initialize: (@options) ->
    @set('title', BancoChile.UIMessages.CHALLENGE_TITLES[@options['kind']])
    description = BancoChile.UIMessages.CHALLENGE_DESCRIPTIONS[@options['kind']]
    @set('description', description + @get('description'))
    @set('action', BancoChile.UIMessages.CHALLENGE_ACTIONS[@options['kind']])

  defaults:
    completed: false
    action: null
    description: null
    n_cards: null
    name: null
    set: null
    title: null
    href: "#challenge-lightbox"

  failureReason: (type)->
    return BancoChile.UIMessages.CHALLENGE_FAILED[type]

class BancoChile.Collections.ChallengesCollection extends Backbone.Collection
  model: BancoChile.Models.Challenge
  url: '/challenges'
