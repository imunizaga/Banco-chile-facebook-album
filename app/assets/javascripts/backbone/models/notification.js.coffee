class BancoChile.Models.Notification extends Backbone.Model
  url: ()->
    url = '/notifications'
    if @id
      return  url + "/" + @id
    else
      return url

  initialize: (@options) ->
    challenge_id = @get('challenge_id')
    if challenge_id
      challenge = window.db.challenges.get(challenge_id)
      kind = challenge.get('kind')
      debugger
      @set('description', BancoChile.UIMessages.NOTIFICATION_DESCRIPTIONS[kind]
           + challenge.get('description'))

  paramRoot: 'notification'

  defaults:
    title: null
    description: null
    details: null
    user_id: null


class BancoChile.Collections.NotificationsCollection extends Backbone.Collection
  model: BancoChile.Models.Notification

  url: '/notifications'
