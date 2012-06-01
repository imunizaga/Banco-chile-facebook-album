class BancoChile.Views.Users.RankingItemView extends Backbone.View
  template: JST["backbone/templates/users/ranking_item"]
  tagName: "li"

  initialize: () ->
    @user = @options.user
    @class = @options.class

  render: =>
    $(@el).html(@template(user: @user.toJSON()))
    return this
