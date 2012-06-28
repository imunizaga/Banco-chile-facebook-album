BancoChile.Views.Challenges ||= {}

class BancoChile.Views.Challenges.FacebookShareView extends BancoChile.Views.Challenges.ChallengeView
  renderAsButton: true

  template: JST["backbone/templates/challenges/fb_share"]

  events:
    "click .js-share-btn": "shareBtnClicked"

  shareBtnClicked: ->
    obj =
      method: 'feed',
      link: 'http://www.magnet.cl',
      picture: 'http://fbrell.com/f8.jpg',
      name: 'Magnet.cl',
      caption: 'Magnet.cl',
      description: 'Nueva empresa de desarrollo de software'

    callback = (response) ->
      console.log("Post ID: " + response['post_id'])

    FB.ui(obj, callback)

  render: ->
    $(@el).html(@template(challenge: @challenge.toJSON() ))
    return this
