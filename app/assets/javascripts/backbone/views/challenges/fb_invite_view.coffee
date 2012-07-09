BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookInviteView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/fb_invite"]
  renderAsButton: true

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    return this

  events:
    "click .js-invite-btn": "inviteBtnClicked"

  inviteBtnClicked: ->
    FB.ui
      method: "apprequests"
      message: BancoChile.UIMessages.INVITE_REQUEST_MESSAGE
    , (response)=>
      toast(BancoChile.UIMessages.INVITE_REQUEST_SENT)
