BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.SmallRankingItemView extends Backbone.View
  template: JST["backbone/templates/users/small_ranking_item"]
  tagName: "li"

  events:
    "click": "clicked"

  initialize: () ->
    @user = @options.user

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    if @className
      $(@el).addClass(@className)
    return this

  clicked: () ->
    console.log('small Ranking User Clicked')
    @trigger('smallRankingUserClicked', @user)
