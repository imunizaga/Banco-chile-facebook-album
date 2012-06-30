BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.TwitterRetweetView extends BancoChile.Views.Challenges.ChallengeView
  template: JST["backbone/templates/challenges/t_retweet"]
  renderAsButton: true
  buttonBinded: false

  events:
    "click .js-twitter-btn": "twitterBtnClicked"

  handleTwitterRetweet: (event)=>
    ### Creates a listener for the twitter retweet event, by checking if the 
    tweet_id is the same as the client_param in the challenge

    # ###
    tweet_id = event.data.source_tweet_id

    # if the tweet_id is correct
    if tweet_id == @challenge.get('client_param')
      console.log("re-tweeted!: " + tweet_id)

      # inform the server that the challenge is complete
      @completeChallenge()

    # un bind the listener, we won't need it anymore
    window.twttr.events.unbind("retweet", (@handleTwitterRetweet))

    # this is for develoment, the button may be bounded again
    @buttonBinded = false

  twitterBtnClicked: ->
    ### Handles the click event of the twitter retweet button in the challenges
    list, by creating a listener for the retweet event, and unbinding the event
    when callback is called

    # ###
    # we need a reference for this view
    if not @buttonBinded
      window.twttr.events.bind("retweet", @handleTwitterRetweet)
      @buttonBinded = true

      window.twttr.events.bind "retweet", (event) ->
        tweet_id = event.data.source_tweet_id
        console.log("re-tweeted!: " + tweet_id)


  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))

    return this
