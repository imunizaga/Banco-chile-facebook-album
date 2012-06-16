BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeView extends Backbone.View
  template: JST["backbone/templates/challenges/challenge"]

  lightboxTemplates:
    like: "fb_like"
    follow: "t_follow"
    invite: "fb_invite"
    code: "code"
    retweet: "t_retweet"
    share: "fb_share"

  tagName: "li"

  events:
    "click .js-action": "actionBtnClicked"

  initialize: () ->
    @challenge = @options.challenge
    templateName = @lightboxTemplates[@challenge.get('kind')]
    @lightboxTemplate = JST["backbone/templates/challenges/" + templateName]

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    $(@el).find(".accion").fancybox()
    return this

  actionBtnClicked: ->
    @trigger('challengeActionClicked', @lightboxTemplate)
