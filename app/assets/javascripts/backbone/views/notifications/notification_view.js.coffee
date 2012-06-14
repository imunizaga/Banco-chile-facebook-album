BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.NotificationView extends Backbone.View
  tagName: "li"

  events:
    'click .js-notification-accept-btn': "acceptBtnClicked"
    'click .js-notification-deny-btn': "denyBtnClicked"

  initialize: () ->
    @model = @options.model
    @user = window.db.users.get(@model.get('user_id'))

    if @model.get('sender_id')
      @template = JST["backbone/templates/notifications/trade"]
      @sender = window.db.users.get(@model.get('sender_id'))
    else
      @template = JST["backbone/templates/notifications/receive"]

  render: =>
    params = 
      notification: @model.toJSON()
      user: @user.toJSON()
    if @sender
      params['sender'] = @sender.toJSON()

    $(@el).html(@template(params))
    return this

  acceptBtnClicked: ->
    @model.set('status', 1)
    @model.save {},
      success: =>
        toast("accepted", "user")

  denyBtnClicked: ->
    toast("denied", "user")
