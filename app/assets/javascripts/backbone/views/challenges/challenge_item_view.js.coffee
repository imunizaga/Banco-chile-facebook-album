BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.ChallengeItemView extends Backbone.View
  template: JST["backbone/templates/challenges/challenge"]

  tagName: "li"
  className: "nueva"

  events:
    "click .js-action": "actionBtnClicked"

  initialize: () ->
    @challenge = @options.challenge
    if @challenge.get('completed')
      @el.className = ""

    switch @challenge.get('kind')
      when 'like'
        challengeView = BancoChile.Views.Challenges.FacebookLikeView
        @image = "sFacebook.jpg"
      when 'invite'
        challengeView = BancoChile.Views.Challenges.FacebookInviteView
        @image = "sFacebook.jpg"
      when 'share'
        challengeView = BancoChile.Views.Challenges.FacebookShareView
        @image = "sFacebook.jpg"
      when 'follow'
        challengeView = BancoChile.Views.Challenges.TwitterFollowView
        @image = "sTwitter.jpg"
      when 'retweet'
        challengeView = BancoChile.Views.Challenges.TwitterRetweetView
        @image = "sTwitter.jpg"
      else
        challengeView = BancoChile.Views.Challenges.CodeView
        @image = "sCode.jpg"

    @challengeView = new challengeView(@challenge)

  render: ->
    ### Render the challenge item in the challenges list
    If the challenge is redered as a button (for example Twitter follow), then 
    the challengeView will replace the normal action button. Else, the normal
    button will remain and when clicked, it will render the challengeView in 
    a lightbox

    ###
    $(@el).html(@template(challenge: @challenge.toJSON(), image: @image))
    if @challengeView.renderAsButton
      $(@el).find(".js-action-container").html(@challengeView.render().el)
    else
      $(@el).find(".accion").fancybox()
    return this

  actionBtnClicked: ->
    @trigger('challengeActionClicked', @challengeView)
