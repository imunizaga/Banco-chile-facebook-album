BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookInviteView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_invite"]
  className: "fb-invite"

  initialize: (options) ->
    @challenge = options.challenge
    super()

  render: ->
    $(@el).html(@template())
    return this

  events:
    "click .js-invite-btn": "inviteBtnClicked"

  inviteBtnClicked: ->
    FB.ui
      method: "apprequests"
      message: BancoChile.UIMessages.INVITE_REQUEST_MESSAGE
    , (response)=>
      toast(BancoChile.UIMessages.INVITE_REQUEST_SENT)
