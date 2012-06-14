BancoChile.Views.Notifications ||= {}

class BancoChile.Views.Notifications.NotificationView extends Backbone.View
  ### The notification view is where the user can see a notification, which can
  be a message or a trade request

  ###
  tagName: "li"

  events:
    'click .js-notification-accept-btn': "acceptBtnClicked"
    'click .js-notification-deny-btn': "denyBtnClicked"

  initialize: () ->
    @model = @options.model
    @user = window.db.users.get(@model.get('user_id'))

    # if the sender_id is set, then it's a trade
    if @model.get('sender_id')
      @template = JST["backbone/templates/notifications/trade"]
      @sender = window.db.users.get(@model.get('sender_id'))
    else # it's a message
      @template = JST["backbone/templates/notifications/receive"]
    @model.bind('change', @render, this)

  render: =>
    # the parameters to be sent to the template are stored in params
    params =
      notification: @model.toJSON()
      user: @user.toJSON()
    # if the sender is set, set the "sender" param
    if @sender
      params['sender'] = @sender.toJSON()

    $(@el).html(@template(params))
    return this

  acceptBtnClicked: ->
    ### handles the accept-button-clicked event
    it sets the status to 1 (accepted) and then posts to the server.
    If if the @sender is set, then handles the trade in the backbone side

    ###
    @model.set('status', 1)
    @model.save {},
      success: =>
        if @sender
          # get the card we are going to receive
          card_in_id = JSON.parse(@model.get('cards_in'))[0]
          card_in = @user.getCard(card_in_id)

          #adjust the incoming card count
          card_in.set('count', card_in.get('count') + 1)

          # get the card we are going to send
          card_out_id = JSON.parse(@model.get('cards_out'))[0]
          card_out = @user.getCard(card_out_id)

          # adjust the incoming card count
          card_out.set('count', card_out.get('count') - 1)

          # tell the user everything went ok
          toast(BancoChile.UIMessages.TRADE_SUCCESS + card_in_id, 'user')

  denyBtnClicked: ->
    ### not implemented yet ###
    toast("denied", "user")
