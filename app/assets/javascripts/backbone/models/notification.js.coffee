class BancoChile.Models.Notification extends Backbone.Model
  url: '/notifications'

  paramRoot: 'notification'

  defaults:
    title: null
    description: null
    details: null
    user_id: null

class BancoChile.Collections.NotificationsCollection extends Backbone.Collection
  model: BancoChile.Models.Notification

  url: '/notifications'
