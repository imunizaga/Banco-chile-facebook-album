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
    if not @model.get('status')
      @el.className = "nueva"

    # if the sender_id is set, then it's a trade
    if @model.get('sender_id')
      @template = JST["backbone/templates/notifications/trade"]
      @sender = window.db.users.get(@model.get('sender_id'))
      if not @sender
        @sender = new BancoChile.Models.User(
          id: @model.get('sender_id')
        )
        @sender.fetch(
          success:()=>
            window.db.users.add(@sender)
            @render()
        )
    else # it's a message
      if @model.get('cards_in')
        @template = JST["backbone/templates/notifications/receive"]
      else
        @template = JST["backbone/templates/notifications/denied"]
    @model.bind('change', @render, this)

  render: =>
    # the parameters to be sent to the template are stored in params
    params =
      notification: @model.toJSON()
      user: @user.toJSON()
    # if the sender is set, set the "sender" param
    if @sender
      params['sender'] = @sender.toJSON()
    else
      params['sender'] = {}

    $(@el).html(@template(params))
    return this

  acceptBtnClicked: ->
    ### handles the accept-button-clicked event
    it sets the status to 1 (accepted) and then posts to the server.
    If if the @sender is set, then handles the trade in the backbone side

    ###
    @el.className = ""
    @model.set('status', 1)
    @model.save {},
      success: =>
        if @sender
          if @user.tradeCards(@model.get('cards_in'), @model.get('cards_out'))
            # tell the user everything went ok
            toast(BancoChile.UIMessages.TRADE_SUCCESS + @model.get('cards_in'), 'user')
          else
            toast(BancoChile.UIMessages.TRADE_FAILED, 'user')
      error: =>
        toast(BancoChile.UIMessages.TRADE_FAILED, 'user')

  denyBtnClicked: ->
    ### handles the deny-button-clicked event
    it sets the status to 2 (denied) and then posts to the server.

    ###
    @model.set('status', 0)
    @model.save {},
      success: =>
        toast(BancoChile.UIMessages.TRADE_DENIED, 'user')
        $(@el).removeClass("nueva")
      error: =>
        toast(BancoChile.UIMessages.TRADE_FAILED, 'user')
