class BancoChile.Models.Notification extends Backbone.Model
  paramRoot: 'notification'

  defaults:
    action: null
    description: null
    details: null
    name: null
    title: null

class BancoChile.Collections.NotificationsCollection extends Backbone.Collection
  model: BancoChile.Models.Notification
  url: '/notifications'
