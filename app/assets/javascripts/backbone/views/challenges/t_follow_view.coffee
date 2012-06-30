BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterFollowView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/t_follow"]
  renderAsButton: true
  buttonBinded: false

  events:
    "click .js-twitter-btn": "twitterBtnClicked"

  handleTwitterFollow: (event)=>
    debugger
    followed_user_id = event.data.user_id
    followed_screen_name = event.data.screen_name
    if followed_screen_name == @challenge.get('client_param')
      console.log("followed!: " + followed_screen_name)
      @completeChallenge()
    window.twttr.events.unbind("follow", (@handleTwitterFollow))
    @buttonBinded = false

  twitterBtnClicked: ->
    ### Handles the click event of the twitter follow button in the challenges
    list, by creating a listener for the follow event, and unbinding the event
    when callback is called

    # ###
    # we need a reference for this view
    if not @buttonBinded
      window.twttr.events.bind("follow", @handleTwitterFollow)
      @buttonBinded = true


  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    return this
