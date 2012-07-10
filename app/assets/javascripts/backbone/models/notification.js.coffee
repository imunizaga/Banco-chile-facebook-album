class BancoChile.Models.Notification extends Backbone.Model
  url: '/notifications'

  initialize: (@options) ->
    if @options['id']
      @url = @url + "/" + @options['id']
    debugger
    challenge_id = @get('challenge_id')
    if challenge_id
      challenge = window.db.challenges.get(challenge_id)
      kind = challenge.get('kind')
      @set('description', BancoChile.UIMessages.NOTIFICATION_DESCRIPTIONS[kind])

  paramRoot: 'notification'

  defaults:
    title: null
    description: null
    details: null
    user_id: null


class BancoChile.Collections.NotificationsCollection extends Backbone.Collection
  model: BancoChile.Models.Notification

  url: '/notifications'
