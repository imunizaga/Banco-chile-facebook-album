BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeItemView extends Backbone.View
  template: JST["backbone/templates/challenges/challenge"]

  tagName: "li"

  events:
    "click .js-action": "actionBtnClicked"

  initialize: () ->
    @challenge = @options.challenge

    switch @challenge.get('kind')
      when 'like'
        challengeView = BancoChile.Views.Challenges.FacebookLikeView
      when 'invite'
        challengeView = BancoChile.Views.Challenges.FacebookInviteView
      when 'share'
        challengeView = BancoChile.Views.Challenges.FacebookShareView
      when 'follow'
        challengeView = BancoChile.Views.Challenges.TwitterFollowView
        @challenge.set("href", "https://twitter.com/intent/user?screen_name=twitterapi")
      when 'retweet'
        challengeView = BancoChile.Views.Challenges.TwitterRetweetView
      else
        challengeView = BancoChile.Views.Challenges.CodeView

    @challengeView = new challengeView(@challenge)

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    $(@el).find(".accion").fancybox()
    return this

  actionBtnClicked: ->
    @trigger('challengeActionClicked', @challengeView)
