BancoChile.Views.Users ||= {}

class BancoChile.Views.Users.SmallRankingItemView extends Backbone.View
  template: JST["backbone/templates/users/small_ranking_item"]
  tagName: "li"

  initialize: () ->
    @user = @options.user

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    return this
