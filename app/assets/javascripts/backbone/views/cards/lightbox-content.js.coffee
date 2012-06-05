BancoChile.Views.Cards ||= {}

class BancoChile.Views.Cards.LightboxContent extends Backbone.View
  initialize: () ->
    @card = @options.card
    @user = @options.user

  render: ->
    $(@el).html(@template(card: @card.toJSON()))
    friendsWithCard = @user.friendsWithCard(@card)

    smallItemTemplate = JST["backbone/templates/users/small_ranking_item"]

    for friend in friendsWithCard.models
      $(@el).find('.js-friend-list').append(smallItemTemplate(
        user: friend.toJSON()
      ))
    return this
