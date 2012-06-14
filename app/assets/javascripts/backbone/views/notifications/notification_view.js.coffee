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
    @model.bind('change', @render, this)

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
        if @sender
          card_in_id = JSON.parse(@model.get('cards_in'))[0]
          card_in = @user.getCard(card_in_id)
          card_in.set('count', card_in.get('count') + 1)
          toast(BancoChile.UIMessages.TRADE_SUCCESS + card_in_id, 'user')

          card_out_id = JSON.parse(@model.get('cards_out'))[0]
          card_out = @user.getCard(card_out_id)
          card_out.set('count', card_out.get('count') - 1)

  denyBtnClicked: ->
    toast("denied", "user")
